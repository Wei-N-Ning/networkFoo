#!/usr/bin/env bash

# ///////////////////////////////////////////////////////////
# see study notes taken from SSH definitive 2nd at the bottom
# ///////////////////////////////////////////////////////////

# motivation:
# in this setup:
# visitor -> [bastion] -> [private vm]
# how can one avoid leaving private key in the bastion server?
# (given that, both bastion and private-vm require ssh key at login)

# source:
# https://dev.to/levivm/how-to-use-ssh-and-ssh-agent-forwarding-more-secure-ssh-2c32

# example: terraformFoo/aws_vpc_take1
# two public instances, one acting like bastion srv;
# the goal is, when login to the private-vm at the bastion srv, one does 
# not private the key

ensure_ssh_agent_running() {
    eval `ssh-agent`  

    # 
}

add_local_keypair() {
    ssh-add
    ssh-add -l
}

login_bastion() {
    ssh -A user@...

    # at the bastion srv, one can directly login to the private vm without
    # providing the private key (again)
    ssh user@pri...
}

# see also:
# https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/ 

# https://stackoverflow.com/questions/12257968/how-to-forward-local-keypair-in-a-ssh-session

# https://serverfault.com/questions/404447/why-is-ssh-agent-forwarding-not-working

# SSH definitive 2nd P256/276
# SSH agent forwarding allows a program running on a remote host 
# such as B (bastion), to access your ssh-agent on H (laptop/workstation)
# transparently, as if the agent were running on B
# thus a remote SSH client running on B can now sign and decrypt data 
# using your key on H, 
# as a result, you can invoke an SSH session from B to your work machine W,
# solving the problem

# How agent forwarding works
# note: my test subjects are: two u18 virtual boxes
# h6: bastion, h7: private instance

# 1. suppose you are logged onto laptop, and you invoke ssh
# to establish a remote terminal session on machine h6

# 2. assuming that agent forwarding is turned on (default sshd config),
# the client says to the ssh server: I would like to request agent 
# forwarding, when eastablish the connection

# 3. sshd on h6 checks its conf to see if it permits agent forwarding
# (default sshd conf)

# 4. sshd on h6 sets up an IPC channel local to h6 by creating some 
# unix domain sockets and setting some environment variables. 
# the resulting IPC mechanism is just like the one ssh-agent sets 
# up. As a result sshd is now prepared to pose as an SSH agent
#                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# 5. your ssh session is now established between laptop and h6

# 6. next from h6, you run another ssh command to establish an 
# ssh session with a third machine h7

# 7. the new ssh client now needs a key to make the connection to 
# h7. It believes there is an agent running on h6, 
# because sshd on h6 is posing as one, so the client makes an 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# authentication request over the agent IPC channel

# 8. sshd intercepts the request, masquerading as an agent, and says
# hello I'm the agent, what would you like to do? the process is 
# transparent: the client believes it is talking to an agent

# 9. sshd then forwards the agent-related request back to the original
#              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# machine, laptop, over the secure connection between laptop and h6,
# the agent on laptop receives the request and accesses your local key,
# and its response is forwarded back to sshd on h6

# 10. sshd on h6 passes the response on to the client, and the connection
# to h7 proceeds 

# 11. agent-forwarding relationship is transitive (as long 
# as every intermediate host enables forwarding)

verify_ssh_agent_forwarding() {
    # add key-pair on laptop
    ssh-add 

    # explicitly enable/disable Agent-Forwarding in sshd config
    # and restart sshd on h6
    # make sure ssh-agent is not running (kill it otherwise)
    # ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
    # connect to h6, then verify the presence/absence of agent-
    # managed keys:
    # (in the case where forwarding is disabled, I will get an error
    # Could not open a connection to your authentication agent.)
    ssh-add -l

    # MAC makes it very hard to developer to trace ssh-agent process
    # see: mac SIP protection
    # one can not attach to the process via LLDB
    # but dtrace can still partially work:
    sudo dtruss -p "$(pgrep ssh-agent)"

    # observe the activity with/without agent forwarding, when 
    # ssh-add -l is executed on h6 remotely

    # dtrace on mac
    # https://stackoverflow.com/questions/31045575/how-to-trace-system-calls-of-a-program-in-mac-os-x

    # trace unix domain socket
    # http://graag.blogspot.com/2007/10/unix-socket-sniffer.html
    #  https://superuser.com/questions/484671/can-i-monitor-a-local-unix-domain-socket-like-tcpdump
}

enable_forwarding() {
    # in client .ssh configure
    ForwardAgent yes

    # or -o 'ForwardAgent=yes'

    # or -A
}

agent_cpu_usage() {
    # SSH definitive 2nd P259/279
    # single ssh-agent used by all these process was eating the 
    # lion's share of CPU
    
    # how to follow one process in htop
    # https://askubuntu.com/questions/545230/anchor-htop-to-one-specific-process
    htop -p "$(pgrep ssh-agent)"
}

debug_agent() {
    # note on mac it could be hard
    # SSH definitive 2nd P/280
    # in debug mode, agent runs in the fg instead of forking, 
    # 
    ssh-agent -d
}

