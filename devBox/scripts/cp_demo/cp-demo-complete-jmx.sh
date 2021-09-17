#!/bin/bash
version="$1-post"
sudo exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum install git curl jq java-1.8.0-openjdk python38 wget net-tools telnet vim -y && echo "Finished installing tools "



# docker install
sudo yum config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && yum install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm -y && yum install docker-ce-3:19.03.9-3.el7 -y && systemctl start docker && systemctl enable docker && echo "Finished installing docker"


#docker compose install
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  && chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && docker-compose --versio && echo "Docker compose version verified" 

# add user to group
groupadd docker
usermod -aG docker ec2-user

export STACK=jmxexporter-prometheus-grafana

#Cloning cp-demo
sudo git clone https://github.com/confluentinc/cp-demo && echo "Finished cloning cp-demo"
cd /home/ec2-user/cp-demo
git checkout $version 

[ -d "cp-demo" ]] || git clone https://github.com/confluentinc/cp-demo.git
(cd /home/ec2-user/cp-demo && git fetch && git checkout 5.5.0-post && git pull)

[[ -d "jmx-monitoring-stacks" ]] || git clone https://github.com/confluentinc/jmx-monitoring-stacks.git
(cd /home/ec2-user/jmx-monitoring-stacks && git fetch && git checkout 5.5.0-post && git pull)


#python 3 needed to be modified
cd /home/ec2-user/cp-demo
sudo sed -ie 's/python/python3/g' ./scripts/helper/functions.sh

echo "Start cp demo script"
cd /home/ec2-user/
chown -R ec2-user:ec2-user /home/ec2-user/cp-demo
chown -R ec2-user:ec2-user /home/ec2-user/jmx-monitoring-stacks
# cd /home/ec2-user/cp-demo
# sudo ./scripts/start.sh
cd /home/ec2-user/jmx-monitoring-stacks
sudo ./jmxexporter-prometheus-grafana/start.sh  && echo "Finished script"



# Installing and setting up ZSH
## Set up ZSH with Oh my Zsh
yum install zsh -y
usermod -s /bin/zsh root
usermod -s /bin/zsh ec2-user

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
cp -R /root/.oh-my-zsh /home/ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/.oh-my-zsh

## Setting theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "/root/.oh-my-zsh/custom/themes/spaceship-prompt"
ln -s "/root/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/root/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
sed -ie "s/ZSH_THEME.*/ZSH_THEME=\"spaceship\"/g" /root/.zshrc

git clone https://github.com/denysdovhan/spaceship-prompt.git "/home/ec2-user/.oh-my-zsh/custom/themes/spaceship-prompt"
unlink /home/ec2-user/.oh-my-zsh/custom/themes/spaceship.zsh-theme
ln -s "/home/ec2-user/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "/home/ec2-user/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
cp ~/.oh-my-zsh/templates/zshrc.zsh-template /home/ec2-user/.zshrc
sed -ie "s/ZSH_THEME.*/ZSH_THEME=\"spaceship\"/g" /home/ec2-user/.zshrc


## ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -ie "s/plugins=(.*/plugins=(zsh-autosuggestions zsh-autosuggestions docker)/g" /root/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions /home/ec2-user/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/ec2-user/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sed -ie "s/plugins=(.*/plugins=(zsh-autosuggestions zsh-autosuggestions docker)/g" /home/ec2-user/.zshrc

chown -R root:root /root/.oh-my-zsh /root/.zshrc
chown -R ec2-user:ec2-user  /home/ec2-user/.zshrc /home/ec2-user/.zshrce /home/ec2-user/.oh-my-zsh /home/ec2-user/cp-demo
