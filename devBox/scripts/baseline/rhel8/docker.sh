#!/bin/bash

echo "Starting docker"
# docker install
## specifically containerd.io-1.2.10-3.2.el7.x86_64.rpm and docker-ce-3:19.03.9-3.el7

# old rhel 8 worked but they moved packages to rhel 7
## sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm -y && yum install docker-ce-19.03.9-3.el7 -y && systemctl start docker && systemctl enable docker && echo "Finished installing docker"
## docker compose install
## sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  && chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && docker-compose --version && echo "Docker compose version verified" 

# currently working for rhel 8
sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && sudo yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-19.03.9-3.el7.x86_64.rpm -y && sudo yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm -y && sudo yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-cli-19.03.9-3.el7.x86_64.rpm -y && sudo systemctl start docker && sudo systemctl enable docker && echo "Finished installing docker"

sudo curl -L "https://github.com/docker/compose/releases/download/1.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose  && sudo docker-compose --version && echo "Docker compose version verified" 


# latest docker install but doesn't work for rhel 8
# sudo yum install -y yum-utils && sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && sudo yum -y install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.2.el7.x86_64.rpm &&  sudo yum install docker-ce docker-ce-cli containerd.io -y && sudosystemctl start docker && systemctl enable docker && echo "Finished installing docker"

#docker compose install
# sudo curl -L "https://github.com/docker/compose/releases/download/1.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose  && sudo docker-compose --version && echo "Docker compose version verified" 



# add user to group
groupadd docker
usermod -aG docker ec2-user

