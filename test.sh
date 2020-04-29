#!/usr/bin/bash

# update
apt update
apt upgrade

# Node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt install nodejs
apt install npm
npm install pm2 -g
