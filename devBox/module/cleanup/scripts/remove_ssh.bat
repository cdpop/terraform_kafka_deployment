#!/bin/bash

HOST=test
HOST_NAME=myhost
IDENTITY_FILE=identity
RANDOM=test123
#remove from config
sed -ie 's/Host "$HOST"-$RANDOM//g' ~/.ssh/config
sed -ie 's/Hostname $HOST_NAME//g' ~/.ssh/config
sed -ie 's/IdentityFile\=$HOME\/\.ssh\/$IDENTITY_FILE-$RANDOM//g' ~/.ssh/config

#remove repo key
rm ~/.ssh/"$IDENTITY_FILE-$RANDOM"*