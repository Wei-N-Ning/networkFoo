#!/usr/bin/env bash

# read this good example:
# https://gist.github.com/vkhatri/9269405

# see this alternative form (inline SendEnv)
# https://superuser.com/questions/163167/when-sshing-how-can-i-set-an-environment-variable-on-the-server-that-changes-f

# this technique is heavily used at CA to implement bastion/jump server:
# local caller make ssh call, sending his AWS credentials in environment variables;
# the remote ssh session receives these variables and create an environment capable 
# of running AWS cli tools 

demo_pass_env_vars() {
    # basis:
    # var=value - this variable won't be inherited by ssh process unless:
    var=value ssh ...
    export var; ssh ...

    # scenario 1
    # ~/.ssh/config:
    # Host testsrv
    #    ... ...
    #    SendEnv KKND
    # ssh session won't receive no env var because service-side is not configured

    # scenario 2
    # server-side: /etc/ssh/sshd_config
    # AcceptEnv KKND
    KKND="1997" DOOM="1993" ssh testsrv
    # ssh session will only receive KKND

    # scenario 3
    # SendEnv DOOM
    # ...
    # Host testsrv
    #   ... ...
    #   SendEnv KKND
    KKND="1997" DOOM="1993" wein@192....
    # ssh session will receive DOOM because it is a global setting
    # NOTE, this won't work if I move SendEnv DOOM to the bottom 
    # below the Host entries
    # KKND is not sent because it is scoped to testsrv entry only
}

