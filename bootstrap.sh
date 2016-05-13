#!/bin/bash


#DEFINE
WEBROOT_PATH="/usr/share/nginx/html"
DOMAIN_NAME="example.com"
WORK_DIR="/opt/letsencrypt"

#PREPARATION

sudo apt-get update
sudo apt-get -y install git

sudo git clone https://github.com/letsencrypt/letsencrypt ${WORK_DIR}

sudo apt-get install nginx

#TO DO:
# 1. Check and remove or update existing config files with the same names.
# 2. Change default server_name via "sed" command as example.

sudo cp ./etc/nginx/default.conf /etc/nginx/sites-available
sudo cp ./etc/nginx/ssl.conf /etc/nginx/sites-available

# TO DO:
# ENABLE DEFAULT AND SSL CONFIGS.
sudo service nginx reload

# TO DO: run ./letsencrypt-auto as service user!
cd ${WORK_DIR}
./letsencrypt-auto certonly -a webroot --webroot-path=${WEBROOT_PATH} -d ${DOMAIN_NAME} --register-unsafely-without-email --agree-tos

#TO DO:
# 1. Check if certs were been created.
#sudo ls -l /etc/letsencrypt/live/${DOMAIN_NAME}

#Generate Strong Diffie-Hellman Group

#TO DO:
# 1. Check if /etc/nginx/ssl exists and create it is not.
# 2. Maybe generate dhparam.pem 4096 but 2048 enought.

sudo openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048

#RENEW
#${WORK_DIR}/letsencrypt-auto renew

#Updating the Let’s Encrypt Client (optional)
#cd ${WORK_DIR}
#sudo git pull
