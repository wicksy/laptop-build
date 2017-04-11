#!/bin/bash

# Testing what? Salt? Ansible?
#
case "${1}" in
salt)
  vagrant="salttest"
  ;;
ansible)
  vagrant="ansibletest"
  ;;
*)
  echo "Invalid test type (salt or ansible only)"
  exit 1
  ;;
esac

# Define tests
#
tests="../test/test_packages.py \
       ../test/test_services.py \
       ../test/test_files.py \
       ../test/test_links.py"

# Run tests using testinfra
#
SCRIPTNAME=$(basename $0)
DIRNAME=$(dirname $0)

# Setup for pip virtual environment
#
export WORKON_HOME=~/.pyenvironments
mkdir -p ${WORKON_HOME}

# Install pips for python virtual environment
#
pip install virtualenv virtualenvwrapper

# Source env wrapper
#
source /usr/local/bin/virtualenvwrapper.sh

# Make a virtual environment to install new pips
#
mkvirtualenv laptop-build

# Upgrade pip and install pips
#
pip install --upgrade pip
pip install testinfra paramiko

# Bring up VM and provision, save ssh key for tests and run tests
#
vagrant up "${vagrant}" --provision \
  && vagrant ssh-config "${vagrant}" > "${vagrant}"-sshkey \
  && testinfra -v --sudo --sudo-user=root --hosts="${vagrant}" --ssh-config="${vagrant}"-sshkey ${tests}

# Exit from the virtual environment and clean it up
#
deactivate
rmvirtualenv laptop-build

exit 0
