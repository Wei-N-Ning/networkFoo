#!/usr/bin/env bash

# source:
# https://stackoverflow.com/questions/3044315/how-to-set-the-authorization-header-using-curl

# motivation:
# how to set the basic authorization header using curl so that 
# I can test the authentication backend?

# see jsExample/http/express/notesusers for an user-authentication 
# micro service that provides the backend

# firstly, spin up foo server

server="localhost:43333"

# --user <username>:<password> <service_url>
curl --user them:60CDDFCE-9CD5-4AA6-88FB-A534621E4579 "${server}/get-foo"


