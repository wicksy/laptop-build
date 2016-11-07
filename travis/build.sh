#!/bin/bash -x
#
# Build - Apply Salt States and Ansible Playbooks
#

# Check versions installed
#
salt-call --version
ansible-playbook --version

exit 0
