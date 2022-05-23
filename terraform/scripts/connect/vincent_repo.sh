#!/bin/bash

# Installing and setting up ZSH
## Set up ZSH with Oh my Zsh
# exec > >(tee /var/log/vincent_repo.log|logger -t zsh -s 2>/dev/console) 2>&1
git clone https://github.com/vdesabou/kafka-docker-playground.git && echo "Finished installing playground"

chown -R ec2-user:ec2-user /home/ec2-user/kafka-docker-playground

