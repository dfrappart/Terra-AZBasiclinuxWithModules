#!/bin/bash

#yum -y update
yum install -y epel-release
yum install -y nginx
systemctl start nginx


echo "bootscript done" > /tmp/results.txt

exit 0