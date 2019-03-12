#!/bin/bash


echo "bootscript initiated" > /tmp/results.txt 
apt-get update -y

apt-get install -y mariadb-server
systemctl start mariadb


echo "bootscript done" >> /tmp/results.txt

exit 0