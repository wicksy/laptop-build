#!/bin/bash -x
#
# Build - Apply Salt States and Ansible Playbooks
#

# Exit on errors
#
set -e
set -u
set -o pipefail

# Create Salt Links for States and Pillar
# Create Ansible Links for Playbooks and Variables
#
mkdir -p /srv
ln -sf "$(pwd)/salt/roots" /srv/salt
ln -sf "$(pwd)/salt/pillar" /srv/pillar
ln -sf "$(pwd)/ansible" /srv/ansible

# Apply Ansible Plays
#
export ANSIBLE_NOCOWS=1
cd /srv/ansible && /usr/bin/ansible-playbook -i hosts site.yml --limit=travis-ci

# Apply Salt States
#
salt-call --local -l warning state.apply

exit 0