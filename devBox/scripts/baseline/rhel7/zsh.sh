#!/bin/bash

# Installing and setting up ZSH
## Set up ZSH with Oh my Zsh
# exec > >(tee /var/log/zsh.log|logger -t zsh -s 2>/dev/console) 2>&1
sudo yum install -y ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/fusion809/CentOS_7/x86_64/zsh-5.7-3.1.x86_64.rpm
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