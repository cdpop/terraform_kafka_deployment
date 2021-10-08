#!/bin/bash

# Add new key to ssh/config
HOST=test
HOST_NAME=myhost
IDENTITY_FILE=identity
RANDOM=test123
cat << EOF >> test

Host "$HOST"-$RANDOM 
        Hostname $HOST_NAME
        IdentityFile=$HOME/.ssh/$IDENTITY_FILE-$RANDOM

EOF

# Generate new key to custom ssh/config
ssh-keygen -t rsa -C "$HOST_NAME" -f "$HOME/.ssh/$IDENTITY_FILE-$RANDOM" -P "$RANDOM" -N "" -q