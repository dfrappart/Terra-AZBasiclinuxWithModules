#!/bin/bash

#yum -y update

yum remove -y docker docker-common docker-selinux docker-engine

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker-ce

systemctl start docker

echo "bootscript done" > /tmp/results.txt

exit 0
