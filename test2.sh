#!/usr/bin/bash

# update
#apt update
#apt upgrade
apt install -y unzip build-essential git pcscd libpcsclite-dev libccid pcsc-tools automake autoconf cmake g++

# driver
wget http://plex-net.co.jp/plex/px-s1ud/PX-S1UD_driver_Ver.1.0.1.zip
unzip PX-S1UD_driver_Ver.1.0.1.zip
cp PX-S1UD_driver_Ver.1.0.1/x64/amd64/isdbt_rio.inp /lib/firmware/

# decoder
git clone https://github.com/stz2012/libarib25.git
cd libarib25
cmake .
make
make install
cd

# rec
wget http://www13.plala.or.jp/sat/recdvb/recdvb-1.3.2.tgz
tar xvzf recdvb-1.3.2.tgz
cd recdvb-1.3.2
./autogen.sh
./configure --enable-b25
make
sudo make install
cd

# Node.js
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
apt install -y nodejs
apt install -y npm
npm install pm2 -g

