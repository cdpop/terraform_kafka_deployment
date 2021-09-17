#!/bin/bash

HOST_NAME=$1
RANDOM_GENERATOR=$2
IDENTITY_FILE=ec2
KEY_PAIR_NAME=$3
#remove from config
sed -ie "s/Host $HOST_NAME-$RANDOM_GENERATOR//g" ~/.ssh/config
sed -ie "s/Hostname $HOST_NAME//g" ~/.ssh/config
sed -ie "s/IdentityFile.*$KEY_PAIR_NAME//g" ~/.ssh/config

#remove repo key
rm ~/.ssh/"$KEY_PAIR_NAME"*