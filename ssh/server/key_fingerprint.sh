#!/usr/bin/env bash

# source: ssh mastery L663

distribute_server_pub_key_fingerprints() {
    # run on u18 vbox:
    # 
    ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub
    # 2048 SHA256:BJNbihv1mEXbXO5SvzEBCCJzcluB21AbJ4jMqHOYqqY root@u18vbox (RSA)
    ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub
    # 256 SHA256:wtb/7WKhEQlIAEewYx5MVHCG4QIPhYxAk7t0H8pliuc root@u18vbox (ED25519)
    ssh-keygen -l -f /etc/ssh/ssh_host_dsa_key.pub
    # 1024 SHA256:n/4xbwy/m9j1aNdWztZOkkWWVVvAgxruWD791SQNdwM root@u18vbox (DSA)
    # 
    # distribute the fingerprints to the user of this server

    # or use ssh-keyscan
    ssh-keyscan -p 22 localhost
    # # localhost:22 SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.1
    # localhost ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC99WTDWDyZ+FapnP/hmAzoR10xuXGhk5R/o7HlB22nq0htPrSI0uLo8GJsrkmfcAJkOtHbJ4fhrdcPqL0X6Br+ACoQ9Ipisb+vm7QnnTLxCZOY6O4y5+SGFZM2NjSWVZZuh4i8U31hYcPm+flzxm6rUlemtW0S5GJFol3rklTJVSKSUUTKbHkAiWIpBvfqshOayCs4ikaKbw8yMWtWcCbf0DirrWys1jYdmiYLziVHpljauWU2FoqytbHkeGjpvZYja5FZej1c0Ffm5aMBhY6qHIAFUWLp6iF2Y7dKp7vT2YFEjWGnC2cCeyb4D56XVKigsFr5EgoSlOWeGVle5lC/
    # # localhost:22 SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.1
    # localhost ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBCCFPUqHVOnFWpJf1IBLnHaEb51wwEC4FX34BaQk2lvvhYH89gSoF4s4bbiuAkI5gLW7J2BpUNWeKI5QckcbapQ=
    # # localhost:22 SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.1
    # localhost ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhrkARE2aEP46kWMA9YJOUZe9QDtRo2dqf+zxJMeEZy

    # client can run ssh-keyscan too:
    ssh-keyscan -p 22 192.168.0.16

    # if port is not open, it prints nothing and returns with code 144
}


