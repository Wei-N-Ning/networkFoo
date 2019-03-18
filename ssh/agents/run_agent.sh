#!/usr/bin/env bash

# source: SSH definitive 2nd P242/262

# agents perform two tasks:
# store your pri keys in memory
# answer questions from ssh clients about those keys

# agents do not send your pri keys anywhere
# once loaded, pri keys remain within an agent, unseen by ssh client

# to access a key, client says:
# perform a key-related operation for me
# the agent obeys and sends the results ot the client

single_shell_agent() {
    # this is method 1
    eval "$(ssh-agent)"

    # to kill
    eval "$(ssh-agent -k)"
}

auto_kill_agent() {
    # SSH definitive 2nd P/265
    # kill ssh-agent when login session ends
    cat >>~/.bash_rc <<"EOF"
trap '
    test -n "${SSH_AGENT_PID}" && eval `ssh-agent -k`;
' 0
EOF
}

launch_shell_with_agent() {
    # this can be seen from CA code base
    # launch a new sub ${SHELL} with an agent, this is method 2
    # ssh-agent runs in the foreground, spawning a subshell and 
    # setting the environment variables automatically.
    # the rest of your login session runs within this subshell, 
    # and when you terminate it, ssh-agent terminates as well

    # /////////////////////////////////////////////////
    # NOTE: your login shell becomes dependent on the agent's health
    # if the agent dies, you login shell may die

    # recapped in SSH definitive 2nd P/525, QA
    ssh-agent "${SHELL}"
}

list_all_public_keys() {
    # -l is to list fingerprints only
    ssh-add -L
}

delete_one_identity() {
    # filename of the private key
    # example: ssh-add -d ~/.ssh/id_rsa
    # Identity removed: /Users/weining/.ssh/id_rsa (weining@MacBook-Pro-8.local)
    ssh-add -d 'filename'
}

delete_all_identities() {
    ssh-add -D
}

set_expire_time_for_key() {
    # example of time syntax: 3W
    ssh-add -t 30 'filename'

    # set maximum lifetime for all keys in the agent
    eval "$(ssh-agent -t 3W)"
}

agent_domain_socket() {
    # SSH definitive 2nd P/274

    # the number in the domain socket filename is usually one less
    # than the process ID of the agent itself, 
    # this is because ssh-agent (the exe) first creates the socket
    # using its pid then later starts another process that actually 
    # persists as the agent

    # reason for the directory-based organization 
    # to deal with such diverse implementations (of domain socket 
    # perm) SSH keeps your sockets in a dir owned by you, with 
    # directory perm that forbid anyone else to access the sockets 
    # inside

    # eval `ssh-agent`
    # Agent pid 1126
    # ll /tmp/ssh-Hz2B8cWlN3Iw/agent.1125
    # srw------- 1 wein wein 0 Mar  9 00:56 /tmp/ssh-Hz2B8cWlN3Iw/agent.1125=
    
    # to move the socket out of the default /tmp directory, 
    # use -a 
    # must provide it the full path
    ssh-agent -a 'filename'
}



