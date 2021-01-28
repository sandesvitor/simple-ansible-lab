#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo cp /vagrant/lab/host_file /etc/hosts
sudo apt-get update && sudo apt-get -y install ansible sshpass

ssh-keygen -q -t rsa -N '' -f /home/vagrant/.ssh/id_rsa <<<y 2>&1 >/dev/null
sshpass -p "vagrant" ssh-copy-id -f -i /home/vagrant/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ubuntu-master
sshpass -p "vagrant" ssh-copy-id -f -i /home/vagrant/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ubuntu-server
sshpass -p "vagrant" ssh-copy-id -f -i /home/vagrant/.ssh/id_rsa.pub -o StrictHostKeyChecking=no ubuntu-database

# Testing:
ansible all -i /vagrant/lab/hosts -m command -a "hostname -I" > /vagrant/test.txt


