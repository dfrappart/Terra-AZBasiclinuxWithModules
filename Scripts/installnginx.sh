#!/bin/bash

echo "bootscript initiated" > /tmp/results.txt 
apt-get update -y

apt-get install -y nginx
systemctl start nginx


echo "bootscript done" >> /tmp/results.txt

exit 0