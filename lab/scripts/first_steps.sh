#!/bin/bash

HOSTNAME=$(hostname)

if [ "$HOSTNAME" = "ubuntu-master" ]
then
    sudo cp /vagrant/hosts_file /etc/hosts

    sudo apt update -y && sudo apt install -y ansible

    ssh-keygen
    echo "yes \n" | ssh-copy-id localhost
    echo "yes \n" | ssh-copy-id web01 && \
        echo "yes \n" | ssh-copy-id web02 && \
        echo "yes \n" | ssh-copy-id loadbalancer && \
        echo "yes \n" | ssh-copy-id db01

    # Testing:
    ansible webstack -i hosts -m command -a hostname > /vagrant/test.txt
fi

