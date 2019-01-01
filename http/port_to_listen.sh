#!/usr/bin/env bash

# source: Terraform up and reading

# listening to port lower than 1024 requires root
# usually http is served on 80,
# but that means the attacker can take over the system;
# there exists a method to have a load balancer listen
# to port 80 and route the traffic to high number
# ports on the server; the server process runs with 
# lesser privilage hence lower the risk


