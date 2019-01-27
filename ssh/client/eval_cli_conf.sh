#!/usr/bin/env bash

# source: ssh mastery L863
eval_cli_conf() {
    # print out the client configuration and exit immediately
    ssh -G -o Port=2222 "user@address"

    cat <<"EXAMPLE"
    ssh -G -o Port=2222 u18
    user wein
    hostname 192.168.0.16
    port 2222
    addkeystoagent false
    addressfamily any
    batchmode no
    canonicalizefallbacklocal yes
    canonicalizehostname false
    challengeresponseauthentication yes
    checkhostip yes
    compression no
    controlmaster false
    enablesshkeysign no
    clearallforwardings no
    exitonforwardfailure no
    fingerprinthash SHA256
    forwardagent no
    forwardx11 no
    forwardx11trusted no
    gatewayports no
    gssapiauthentication no
    gssapidelegatecredentials no
    hashknownhosts no
    hostbasedauthentication no
    identitiesonly no
    kbdinteractiveauthentication yes
    nohostauthenticationforlocalhost no
    passwordauthentication yes
    permitlocalcommand no
    proxyusefdpass no
    pubkeyauthentication yes
    requesttty auto
    streamlocalbindunlink no
    stricthostkeychecking ask
    tcpkeepalive yes
    tunnel false
    verifyhostkeydns false
    visualhostkey no
    updatehostkeys false
    canonicalizemaxdots 1
    connectionattempts 1
    forwardx11timeout 1200
    numberofpasswordprompts 3
    serveralivecountmax 3
    serveraliveinterval 0
    ciphers chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
    hostkeyalgorithms ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519,rsa-sha2-512,rsa-sha2-256,ssh-rsa
    hostbasedkeytypes ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519,rsa-sha2-512,rsa-sha2-256,ssh-rsa
    kexalgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1
    casignaturealgorithms ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519,rsa-sha2-512,rsa-sha2-256,ssh-rsa
    loglevel INFO
    macs umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
    pubkeyacceptedkeytypes ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519,rsa-sha2-512,rsa-sha2-256,ssh-rsa
    xauthlocation xauth
    identityfile ~/.ssh/id_rsa
    identityfile ~/.ssh/id_dsa
    identityfile ~/.ssh/id_ecdsa
    identityfile ~/.ssh/id_ed25519
    identityfile ~/.ssh/id_xmss
    canonicaldomains
    globalknownhostsfile /etc/ssh/ssh_known_hosts /etc/ssh/ssh_known_hosts2
    userknownhostsfile ~/.ssh/known_hosts ~/.ssh/known_hosts2
    sendenv LANG
    sendenv LC_*
    connecttimeout none
    tunneldevice any:any
    controlpersist no
    escapechar ~
    ipqos af21 cs1
    rekeylimit 0 0
    streamlocalbindmask 0177
    syslogfacility USER

    echo $?
    0
EXAMPLE
}