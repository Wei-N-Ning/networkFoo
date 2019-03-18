#!/usr/bin/env bash

# SSH definitive 2nd P/466

: <<"TEXT"
suppose your commpany has a gateway host G, which is your only 
gateway to the internet. you are logged into a client host C and 
want to reach a server host S outside the company network.

corp network
[   C G   ] -- internet --> S

P/466
the remote command 'ssh S' needs a terminal;
you can fix this with the -t switch for a pseudo-terminal
ssh -t G ssh S
(see case study 1: with_pseudo_terminal())
TEXT

with_pseudo_terminal() {
    # use CA dev.jump and dev.solr6.0 as test subjects
    ssh -q -A -t \
        wei@ec2-18-213-29-236.compute-1.amazonaws.com \
        'ssh -q ubuntu@10.0.9.58'
    # 1. reverse engineering ~/.ssh/dev.jump.config
    
    # Host dev.jump
    # Hostname ec2-18-213-29-236.compute-1.amazonaws.com
    # User wei
    # SendEnv AWS_ACCESS_KEY_ID
    # SendEnv AWS_SECRET_ACCESS_KEY
    # SendEnv AWS_SESSION_TOKEN
    # SendEnv AWS_DEFAULT_REGION
    # IgnoreUnknown UseKeychain
    # UseKeychain yes
    
    # the only interesting part here is 'Hostname' and 'User'
    # the other bits are merely to give the user on dev.jump
    # some permission to read 'secrect' so that it can proceed 
    # to login to the next host (solr6)

    # 2. reverse engineering the remote login command

    # it uses ProxyCommand (see cases in the book), but it is 
    # really just to tell the remote host solr6 that, the calling 
    # user (wei) has access because it has the 'secrect'

    # I've simplified this

    # on solr6 I've added my own public key so that using agent-
    # forwarding I can run the above command; I've also stripped
    # the entire ssh config because most of it is irrelevant now 

    # the downside is that the remote host has to actively download 
    # all the users' public key and actually create these Linux
    # users

    # otherwise I need a way to 1) ssh-add the key pair for the 
    # remote server 2) use agent-forwarding
    # the first part can be done by
    aws ssm get-parameter --name /ec2/pem/dev.solr --profile dev \
    --with-decryption --output text --query "Parameter.Value" | \
    ssh-add -

    # to verify, I deleted my own pub-key from the remote host
    # (solr6), then the above command failed with pubkey error 
    # as I could not pass the key pair test;
    # at this moment I did not own the host's secret

    # after downloading the secret from ssm and turning on 
    # agent-forwarding I could connect again

}

: <<"TEXT"
P/466

suppose your account on gateway G is gillign and on server S is 
skipper..... 
Next, on gateway G, associate a forced command with your chosen
 key to invoke an SSH connection to server S

NOTES: 
the example in the book I think, assumes user gillign and
skipper has the *same* key pair;
in CA's environment, the user on dev.jump (wei) and the user 
on the remote host solr6 (ubuntu) may not have the same key pair
 but there is nothing stopping that

//// IMPORTANT NOTE ////
The server config entry AuthorizedKeysCommand seems to nullify 
the per-user force command.

NOTES:
I do like how it hides/encapsulates the second ssh command in 
the authorized_keys file:
command="/bin/bash -c 'ssh -l skipper S ${SSH_ORIGINAL_COMMAND:-}'" ...key...
in other environments when it is usable, I may give it a try
TEXT

: <<"TEXT"
SSH definitive 2nd P/471

IF a ProxyCommand value is set, open ssh uses this command to get
a communication channel to the remote host, rather than using the 
network directly.
In this case we actually use a second ssh command to connect 
through gateway G ot hte ssh server TCP  port on server S

The trick is that we really want a kind of connection that 
open ssh does not provide: 
- connect to G via SSH, 
- instruct G to make a TCP connection to host S port 22, 
- and connect the local stdin/stdout to that stream.

we must have a separate program on G, which just makes a simple 
TCP connection for us (nc)

the proxy command technique is simpler than port forwarding:

there is no extra SSH command to start separately and no ad hoc 
port numbers to coordinate and possibly have to change.
it also gains in security since port forwarding always has the 
problem of unauthenticated access to the forwarded connection 
(-G, or localhost)
and we need no HostKeyAlias statements
however we lose the speed advantage gained over chained ssh 
commands, since once again we end up waiting for two ssh 
connections every time.

TEXT

with_proxy_command() {
    ssh \
    -o ProxyCommand=\
    "ssh wei@ec2-18-213-29-236.compute-1.amazonaws.com nc 10.0.9.58 22" \
    ubuntu@10.0.9.58
    
    # pen ssh uses this command to get a communication channel 
    # to the remote host, rather than using the network directly 
    # this is the comm channel:
    # ssh wei@ec2-18-213-29-236.compute-1.amazonaws.com nc 10.0.9.58 22

    # it still requires normal ssh authentication, therefore
    # I need to pass the keypair test:
    # I either add my pub key locally and forward the agent
    # or I add my pub key to the destination
    # either way I'm being tested by the destination host directly
    # provided that the comm channel can be established in the 
    # first place - which requires a separate authentication!!!
    #  
    # this subjects to the same keypair restriction as explained 
    # in the first use case 
    # 
    # in CA environment the secrets are stored in SSM secret store 
    # or parameter store in CN regions
}

