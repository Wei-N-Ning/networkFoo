#!/usr/bin/env bash

# SSH definitive 2nd P364/384
# 9.2.5

: <<"TEXT"
Your home machine H talks to work machine W via a bastion host B.
H: laptop
B: bastion
W: work machine/ corporate instance

You want to access your work email from home. Machine W runs an 
IMAP server and your laptop H has an IMAP-capable email reader,
but you can't hook them up. Your home IMAP client expects to make 
a TCP connection directly to the IMAP server on W, but that conn
is blocked by the firewall. 

Since B is inside the firewall and it's running an SSH server,

ssh -L 2001:W:143 B

This establishes an interactive SSH session from H to B and also 
creates an SSH tunnel from localhost H to the email server on W.
Specially in response to a conn on port 2001, the local SSH client 
directs the SSH server running on B to open a conn to port 143 on 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
W, that is socket W:143. 
The SSH server can do this because B is inside the firewall.
If you configure your email reader to connect to local port 2001, 
the communication path is:

1. the email reader on home machine H sends data to local port 2001
2. the local SSH client reads port 2001, encrypts the data and sends 
    it into the tunnel
3. the tunnel passes through the firewall, because it is an SSH 
    conn (port 22) that the firewall accepts
4. the SSH server on B decrypts the data and sends it to port 143
    on W. This transmission isn't encrypted but it is protected 
    behind the firewall, so encryption isn't necessary 
5. data is sent back from the IMAP server to home machine H by 
    the same process in reverse.

You have now bypassed the firewall.
TEXT

# here is my own exercise using h6, h7 and a laptop
# h6: bastion, no firewall
# h7: corporate instance, firewall ufw:
#   9080: ALLOW IN 192.168.0.6 (bastion)
#     22: ALLOw IN 192.168.0.6 (bastion)
# laptop: needs to connect to corp instance h7
exercise_bypassing_firewall() {
    ssh h7 
    # connection is rejected

    ssh h6 
    sudo /usr/sbin/sshd -p 2222 -d
    # launch a temporary sshd server in debug mode to 
    # observe the forwarding activities
    # note the debug message: 
    # connect_next: host .... (.., 22) in progress

    # on laptop
    # recall: -N 
    # Do not execute a remote command.  This is useful for just 
    # forwarding ports
    ssh -N -p 2222 -L 2222:192.168.0.7:22 wein@192.168.0.6
    # to forward local port 2222 to remote port 22 on corp instance,
    # using ssh server running on bastion as the tunnel

    # once successful, 
    # delete the known_host entry for localhost (otherwise ssh
    # client will complain and refuse to connect)
    ssh wein@localhost -p 2222

    # this will use the authentication method selected by the 
    # SSH server running on corp instance. In my case, if I remove 
    # my public key from authorized_keys on the corp instance, 
    # I will be prompted for password; otherwise I can get in 
    # immediately

    # to use the production ssh server on bastion
    ssh -N -L 2222:192.168.0.7:22 wein@192.168.0.6
}

# P/386
# 9.2.6 Port Forwarding without a Remote Login
bastion_techniques_oneshot() {
    # reuse the exercise above
    
    # P/387
    # one-shot forwarding, which cuases the client to exit when 
    # forwarding is over with. Specifically, the client waits 
    # indefinitely for the first forwarded connection. 
    # after that when the number of forwarded connections drop
    # to zero, the client exits

    # 1. set up the forwarding with ssh -f and for the 
    # required remote command, use sleep with a short duration

    # 2. before the sleep interval expires, use the forwarded conn
    
    # once the sleep command finishes, the first ssh tries to 
    # exit- but it notices a forwarded conn is in use and refuses 
    # to exit, printing a warning you can ignore
    
    # ssh waits until that connection ends, and then terminates
    # providing the behavior of one-shot forwarding
    ssh -f -L 2222:192.168.0.7:22 wein@192.168.0.6 sleep 5

}


