#!/bin/bash

adduser -g100 docker

mkdir -p /home/docker
ln /home/docker /root/docker -s

#Add the docker repository 
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#Install the needed packages
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Start and enable the systemd docker service (dockerd)
sudo systemctl --now enable docker
