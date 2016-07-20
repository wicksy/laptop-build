#!/bin/bash

# Script to bootstrap Ubuntu Server Laptop (using Ansible)
#

/usr/bin/apt-add-repository -y ppa:ansible/ansible
/usr/bin/apt-get update
/usr/bin/apt-get -y install laptop-mode-tools python python-pip git software-properties-common ansible sudo
mkdir -p /git/wicksy /srv
cd /git/wicksy && /usr/bin/git clone https://github.com/wicksy/laptop-build.git
/bin/ln -sf /git/wicksy/laptop-build/ansible /srv/ansible
/usr/sbin/useradd -m -d /home/ansible -s /bin/bash ansible
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
echo -e 'y\n' | /usr/bin/sudo -H -u ansible /usr/bin/ssh-keygen -f /home/ansible/.ssh/id_rsa -t rsa -N ''
/bin/cat /home/ansible/.ssh/id_rsa.pub >> /home/ansible/.ssh/authorized_keys
/bin/chmod 600 /home/ansible/.ssh/authorized_keys
/bin/chown ansible:ansible /home/ansible/.ssh/authorized_keys
