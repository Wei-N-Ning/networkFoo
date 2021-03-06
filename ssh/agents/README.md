# Agent forwarding

source: ssh mastery L1442

see: ssh_agent_forwarding.sh for a detailed example using CA's
network environment.

## motivation of agent forwarding

I'm working on my server A, and must copy a file
over A to the server B. This presents a problem: My private key
isn't on A.

Copying the private key to a server is terrible
security practice - you want your private key
on as few hosts as possible, and never on your
servers.

the answer is to forward authentication request from server A
back to your workstation. Agent forwarding is
exactly that.

## mechanism

source SSH definitive P30/50

when agent forwarding is turned on, the remote SSH server
masquerades as a second ssh-agent.

it takes authentication requests from your SSH client
processes running there (on server A), passes them back over the
SSH connection (which is secure) to the local agent for handling,
and relays the results back to the remote clients.

since any programs executed via ssh on the remote side are
children of the server, they all have access to the local
agent just as if they were running on the local host
