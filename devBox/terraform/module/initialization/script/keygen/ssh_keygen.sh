#!/bin/bash

# Add new key to ssh/config
HOST_NAME=UNKNOWN

IDENTITY_FILE=ec2
RANDOM_GENERATOR=$1
USER_NAME=$2
KEY_PAIR_NAME=$3
# Generate new key to custom ssh/config and save it as $HOME/.ssh/ec2-$RANDOM_GENERATOR
ssh-keygen -t rsa -C "$USER_NAME" -f "$HOME/.ssh/$KEY_PAIR_NAME" -P "" -N "" -q 

# edit config file
cat << EOF >> $HOME/.ssh/config

Host $HOST_NAME-$RANDOM_GENERATOR 
        Hostname $HOST_NAME
        IdentityFile $HOME/.ssh/$KEY_PAIR_NAME

EOF

