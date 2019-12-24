#!/bin/bash

# 1. create account user   username password
GIT_USER=$1
GIT_TOKEN=$2

if [ -z ${GIT_USER} ]
then
echo 'please input git user'
exit 1;
fi

if [ -z ${GIT_TOKEN} ]
then
echo 'please input git token'
exit 1;
fi

USERNAME=qitmeer
PASSWORD=0.8.5+dev

REPO=github.com/dindinw/qitmeer


sudo useradd -m  -p $(openssl passwd -1 ${PASSWORD})  -s /bin/bash $USERNAME

whoami
sudo -i -u ${USERNAME} bash << EOF_SUDO
whoami

git clone https://${GIT_USER}:${GIT_TOKEN}@${REPO} ~/${REPO} --depth=1
cd ~/${REPO}

mkdir -p qitmeerd

cat << EOF_CAT >  qitmeerd/qitmeer.conf
rpclisten=0.0.0.0:28131
rpcuser=${USERNAME}
rpcpass=${PASSWORD}
txindex=1
testnet=1
listen=0.0.0.0:28130
notls=1
externalip=$(wget -qO - ifconfig.me):28130
customdns=seed.dag.team
getaddrpercent=100
port=28130

EOF_CAT

cat qitmeerd/qitmeer.conf

git pull https://${GIT_USER}:${GIT_TOKEN}@${REPO} master
make
pidof qitmeer
killall qitmeer
nohup ./build/bin/qitmeer -A ./qitmeerd &
pidof qitmeer
sleep 1

EOF_SUDO
whoami


