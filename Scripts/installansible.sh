#!/bin/bash

echo "bootscript initiated" > /tmp/results.txt 
apt-get update -y
apt-add-repository ppa:ansible/ansible > /dev/null
apt-get install -y ansible
ansible --version >> /tmp/result.txt


echo "bootscript done" >> /tmp/results.txt

exit 0