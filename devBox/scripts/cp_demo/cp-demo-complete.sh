#!/bin/bash
version="$1-post"

echo "\n\n\n\n\n\n Pops version $version"
#Cloning cp-demo
sudo git clone https://github.com/confluentinc/cp-demo && echo "Finished cloning cp-demo"
cd /home/ec2-user/cp-demo
git checkout $version 

# [ -d "cp-demo" ]] || git clone https://github.com/confluentinc/cp-demo.git
# (cd /home/ec2-user/cp-demo && git fetch && git checkout 5.5.0-post && git pull)

# [[ -d "jmx-monitoring-stacks" ]] || git clone https://github.com/confluentinc/jmx-monitoring-stacks.git
# (cd /home/ec2-user/jmx-monitoring-stacks && git fetch && git checkout 5.5.0-post && git pull)


#python 3 needed to be modified
cd /home/ec2-user/cp-demo
sudo sed -ie 's/python/python3/g' ./scripts/helper/functions.sh

echo "Start cp demo script"
cd /home/ec2-user/
chown -R ec2-user:ec2-user /home/ec2-user/cp-demo
cd /home/ec2-user/cp-demo   
sudo ./scripts/start.sh
# cd /home/ec2-user/jmx-monitoring-stacks
# sudo ./jmxexporter-prometheus-grafana/start.sh  && echo "Finished script"



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
