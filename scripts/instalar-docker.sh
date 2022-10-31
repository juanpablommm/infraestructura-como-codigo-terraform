#!/bin/bash

# Instalar Docker
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker

#Agregar el usuario ec2-user al grupo docker
sudo groupadd docker
sudo usermod -aG docker ec2-user