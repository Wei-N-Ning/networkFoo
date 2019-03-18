#!/usr/bin/env bash

# SSH definitive 2nd P/466

: <<"TEXT"
Comparison of different bastion/gateway techniques

Smoothness:
+ the tunneling methods are smoother end to end
this is especially true if you need to request additional 
services via ssh, such as any kind of forwarding...
- the setup for tunneled connections using port forwarding
is more cumbersome with its extra ssh process

+ proxy command tunneling is both smoother than chaining 
and at least no slower

Security
a chained connection has a serious security problem: 
- the gateway G , all data is decrypted on G in between the 
two SSH sessions; if G is compromised all is lost
- there is no end to end security in this scenario, because 
there is no actual ssh session from client C to server S
+ a compromised G poses no extra threat to the security of a 
tunneled ssh connection from C to S; the break-in simply puts 
the attacker on G in the possition of altering or diverting the 
data path between C and S - but SSH already has mechanism for 
countering exactly that threat. In other words, the top SSH
connection does not trust the lower one at all.

TEXT

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

with_port_forwarding() {
    # process to establish forwarding:
    ssh -N -A -L 2222:10.0.9.58:22 wei@34.234.15.97

    # procees to connect to the forwarded local port
    ssh -A -o UserKnownHostsFile=/dev/null ubuntu@localhost -p 2222
    
    # gotcha 1:
    # 2222:10.0.9.58:22 ***MUST NOT*** be written as
    # 2222:ubuntu@10.0.9.58:22
    # the username information is not part of the forwarding 
    # setup as ssh does not care about that; sshd will complain
    # about the host name ubuntu@10.0.9.58 but this message is 
    # only shown in debug-verbose mode (-ddd, -d3 or -d5)
    # note that the client side -vvv can be helpful BUT not in 
    # this case; it does not know why server rejects the req
    # the username should be provided to the connecting command 
    # as shown above

    # gotcha 2:
    # because localhost likely exists in user's known host file
    # and because my ssh client is likely running in strict mode 
    # therefore connection will fail with the follow error 
    # REMOTE HOST IDENTIFICATION HAS CHANGED!
    # the work around is to 1) delete the localhost entry 2)
    # tell ssh client not to save this entry any more, hence
    # the argument -o UserKnownHostsFile=/dev/null

    # gotcha 3:
    # I will be interrogated by the destination host for keypair,
    # make sure the connecting command use agent forwarding (-A)
    # note that I also use -A for establishing forwarding, this 
    # is to pass the test on the jump host, if I don't use 
    # my default keypair

    # the same forwarding technique works for other connection
    # types (such https)
    # for example this establishes a tunnel to a private 
    # instance that runs solr6 server,
    # once established, one can log on to the solr admin page 
    # in a browser via localhost:2222
    # note again the port:host:port syntax (no username!!)
    ssh -N -A -L 2222:10.0.9.58:8983 wei@34.234.15.97
}