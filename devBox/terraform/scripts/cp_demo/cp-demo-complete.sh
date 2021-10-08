#!/bin/bash
version=$1

#Cloning cp-demo
sudo git clone https://github.com/confluentinc/cp-demo && echo "Finished cloning cp-demo"
cd /home/ec2-user/cp-demo
git checkout $version 



#python 3 needed to be modified
cd /home/ec2-user/cp-demo
sudo sed -ie 's/python/python3/g' ./scripts/helper/functions.sh

echo "Start cp demo script"
cd /home/ec2-user/
chown -R ec2-user:ec2-user /home/ec2-user/cp-demo
cd /home/ec2-user/cp-demo   

sudo ./scripts/start.sh

echo "Finished starting."