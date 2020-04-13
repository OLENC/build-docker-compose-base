#!/bin/bash
#设置时区
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://mirrors.aliyun.com/debian jessie main contrib non-free" >/etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/debian jessie main contrib non-free" >>/etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >>/etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >>/etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/debian-security jessie/updates main contrib non-free" >>/etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/debian-security jessie/updates main contrib non-free" >>/etc/apt/sources.list
openssl rand -base64 741 >mongodb-keyfile
chmod 600 mongodb-keyfile
chown 999 mongodb-keyfile
apt update
dpkg --configure -a
apt install procps vim iproute2 curl wget netcat htop jq net-tools sudo -y

mongod -f /data/mongo/config/my.cnf &

echo -e "alias ll='ls -l'\nexport LC_ALL=C.UTF-8\nTZ='Asia/Shanghai'" >>/root/.bashrc
source /root/.bashrc

eval $@
tail -f /dev/null
