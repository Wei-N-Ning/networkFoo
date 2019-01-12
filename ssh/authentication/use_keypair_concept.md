
# public key

the pub key is uploaded to the vm:

```sh
ubuntu@ip-10-0-1-189:~$ cd ~/.ssh/
ubuntu@ip-10-0-1-189:~/.ssh$ ll
total 20
drwx------  3 ubuntu ubuntu 4096 Jan 12 02:00 ./
drwxr-xr-x  6 ubuntu ubuntu 4096 Jan 12 01:56 ../
-rw-------  1 ubuntu ubuntu  396 Jan 12 00:29 authorized_keys
drwxr-xr-x 19 ubuntu ubuntu 4096 Jan 12 02:00 networkfoo/
-rw-r--r--  1 ubuntu ubuntu  268 Jan 12 01:49 run_commands.sh
ubuntu@ip-10-0-1-189:~/.ssh$ cat authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDP3BgOBYGUNb/hmh5yQQL3aFbogs4uz9sRrX2MGvnHcYZlh58k0NMgXqllaTStNgnohzNNOaR6HswtZb9r1NjzyHcaIUny9SVjfXHa6o+bdanMMnHLSxHiR4hK2oFdN3YGWridmntd1tk6ZUfC5DKzjAGw4ywh+WWIf364Nxon3f9294sC9ziuymhOqMSp2QIK9E1VV+nqK6q9gQLbZIs8jrRxTfW2YR/mT3B/uLVIbB4Kg3KX+qc8+/s6xEHAiWdbYUaDxUak73cahhCm5/ovHxW4KvEr3TQzaoKNCqR8P6R8xV9wcRxx6MzVPmMC0UrgH9F0EDBnJD/Yba+6ulRt mortalenginex2
```

note how the content of the public key is written to the authorized_keys file

the private key must be provided at login time:

`-i mortalenginex2.enc`

# private key

to demo how effective the private key is:

generate a new key pair without password
`ssh-keygen -t rsa -f ~/foo`

override VM's .ssh/authorized_keys with foo.pub

login with foo:
`ssh -i ~/foo user@...`

since I'm using a new key pair without password, it no longer asks me for password... (the VM is compromised)

