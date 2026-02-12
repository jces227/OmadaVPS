#!/bin/bash

echo "Installing Omada Cloud by Arclem"

echo "Install Java 17"
sudo apt update
sudo apt install -y openjdk-17-jre-headless

echo "Install JSVC"
sudo apt install -y jsvc

echo "Install required tools"
sudo apt install -y gnupg curl

echo "Import MongoDB 7 GPG Key"
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "Add MongoDB Repository"
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

echo "Install MongoDB v7"
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

echo "Install Omada v6"
sudo wget https://static.tp-link.com/upload/software/2026/202601/20260121/Omada_Network_Application_v6.1.0.19_linux_x64_20260117100106.deb
sudo dpkg --ignore-depends=jsvc -i Omada_Network_Application_v6.1.0.19_linux_x64_20260117100106.deb
sudo apt -f install
sudo systemctl start tpeap
sudo systemctl enable tpeap

echo "Install nginx and php8.1-fpm"
sudo apt update
sudo apt install -y nginx php-fpm php-curl php-mysql git unzip
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable php8.1-fpm
sudo systemctl start php8.1-fpm









