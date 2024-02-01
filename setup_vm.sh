#!/bin/bash

# WIP - Don't run

# Install Packages
sudo apt-get -y update
sudo apt-get -y install git make tmux unzip

# Fix Proxy for DNS - To Reevaluate
sudo systemctl stop systemd-resolved.service
sudo rm /etc/resolv.conf
printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee -a /etc/resolv.conf

sudo rm /etc/NetworkManager/NetworkManager.conf
sudo touch /etc/NetworkManager/NetworkManager.conf
printf "[main]\ndns=default" | sudo tee -a /etc/NetworkManager/NetworkManager.conf

# Install Go
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install EvilGinx3
wget https://github.com/kgretzky/evilginx2/archive/refs/tags/v3.2.0.tar.gz
sudo tar -C /opt/evilginx -xvf v3.2.0.tar.gz

# Install GoPhish
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
unzip gophish-v0.12.1-linux-64bit.zip -d /opt/
chmod +x /opt/gophish/gophish


