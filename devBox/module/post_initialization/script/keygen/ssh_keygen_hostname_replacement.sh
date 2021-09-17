#!/bin/bash

# replace UNKNOWN hostname in config file
# need to run this script post generating the AWS EC2 instance
EC2_NAME=$1

sed -ie "s/UNKNOWN/$EC2_NAME/g" $HOME/.ssh/config