#!/bin/bash

echo "Ip to bind pool daemon to (server's IP)"
read bindip
echo "Enter pool IP to connect to, including port, usually :3333"
read poolip

useradd -M ckpool
usermod -L ckpool

mkdir /etc/ckpool
mkdir /var/log/ckpool/
chown ckpool:ckpool /var/log/ckpool/ -R

sed "s/{poolip}/${poolip}/g" proxy.conf > /etc/ckpool/ckpool.conf
cp /etc/ckpool/ckpool.conf /etc/ckpool/ckpool.conf.tmp
sed "s/{username}/asdf/g" /etc/ckpool/ckpool.conf.tmp > /etc/ckpool/ckpool.conf
cp /etc/ckpool/ckpool.conf /etc/ckpool/ckpool.conf.tmp
sed "s/{localip}/${bindip}/g" /etc/ckpool/ckpool.conf.tmp > /etc/ckpool/ckpool.conf
rm /etc/ckpool/ckpool.conf.tmp

# Make Linux network better
echo 'net.core.wmem_max=12582912' >> /etc/sysctl.conf
echo 'net.core.rmem_max=12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_rmem= 10240 87380 12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_wmem= 10240 87380 12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_window_scaling = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_sack = 1' >> /etc/sysctl.conf
echo 'net.core.netdev_max_backlog = 20000' >> /etc/sysctl.conf
sysctl -p

# Install CKproxy

cp ckpoolproxy-multiuser.service /etc/systemd/system/ckpool.service
systemctl enable /etc/systemd/system/ckpool.service
systemctl start ckpool
