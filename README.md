[![Build Status](https://travis-ci.org/wicksy/laptop-build.svg?branch=master)](https://travis-ci.org/wicksy/laptop-build) [![license](https://img.shields.io/badge/License-MIT-blue.svg?maxAge=2592000)](https://github.com/wicksy/laptop-build/blob/master/LICENSE.md)</br>

## Laptop Build Automation

#### Overview

![Saltstack logo](logos/saltstack.png "Saltstack")
![Ansible logo](logos/ansible.png "Ansible")

Salt and Ansible used to configure a number of Linux laptops that I currently use.

#### Tested Against

Tested on the following laptops:

* Dell Inspiron running Ubuntu 16.04 (tested with Ansible only)
* Dell Inspiron running Ubuntu 15.10 (tested with Salt/Ansible)
* Dell Inspiron running Ubuntu 14.04 (tested with Salt only)
* Samsung Q45 running Ubuntu 14.04 (32-bit) (tested with Ansible only)

Tested on the following VMs:

* Ubuntu 16.04 (tested with Salt/Ansible)
* Ubuntu 14.04 (tested with Salt/Ansible)

Does not work with the following:

* Ubuntu 14.04 32-bit (Salt does not bootstrap - even older versions back to 0.15.0)

Currently testing with Ansible 2.4.0.0.

#### Pre Installation

If using this automation for your own laptop setup you might want to do the following prior to running Salt/Ansible:

* Change `users` Salt pillar/Ansible group vars dictionary to make your userid with your user details (including your password hash)
* Change `sshkeys` Salt pillar/Ansible group vars dictionary to install your public SSH key in your authorized keys file
* Change `wicksy` to your userid in any Salt state files/Ansible playbooks
* Change `gpg.batch` Salt/Ansible templates to set your own user details including passphrase on your gpg keys (you can change it afterwards as well)

#### Installation

* Obtain and run a copy of the following script to configure the wifi adapter:

```
$ https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/bootwifi.sh
```

* To configure the laptop using Salt:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/salt/bootstrap.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/sudo salt-call --local -l debug state.highstate
```

* To configure the laptop using Ansible:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ansible/bootstrap.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/sudo -H -u ansible /bin/bash -c "cd /srv/ansible && /usr/bin/ansible-playbook --limit localhost -i /srv/ansible/hosts /srv/ansible/site.yml -vv"
```

#### Post Installation

Post installation steps might include:

* Change the passphrase on the gpg key setup for your userid (if not changed in Pre Installation)

#### Builds

Builds are triggered automatically and run on [Travis CI](https://travis-ci.org/wicksy/laptop-build/builds). The build will apply the Salt states and Ansible plays in a build VM and run the tests to ensure code validity.

#### Tests

There are a number of tests implemented using the serverspec-like testing framework for Python [**testinfra**](https://github.com/philpep/testinfra). Tests
can be run using the `runtests.sh` bash script in the `test` directory:

```
$ cd test
$ ./runtests.sh ansible
$ ./runtests.sh salt
```

The script will bring up a vagrant machine if not already, setup a python virtual environment, install testinfra and paramiko pips, run a series of test
packs through testinfra then clean up afterwards. There is one vagrant host to test the Salt states and one to test the Ansible playbooks.

Sample output from one of the test packs (for services):

```
========================================================= test session starts ==================================================================
platform darwin -- Python 2.7.10, pytest-3.0.1, py-1.4.31, pluggy-0.3.1 -- /Users/wicksy/.pyenvironments/laptop-build/bin/python
cachedir: .cache
rootdir: /Users/wicksy/git/wicksy/laptop-build/test, inifile:
plugins: testinfra-1.4.2
collected 4 items

test_services.py::test_services[paramiko://ansibletest-cron-enabled-running] PASSED
test_services.py::test_services[paramiko://ansibletest-docker-enabled-running] PASSED
test_services.py::test_services[paramiko://ansibletest-haveged-enabled-running] PASSED
test_services.py::test_services[paramiko://ansibletest-ssh-enabled-running] PASSED

======================================================== pytest-warning summary ================================================================
WP1 None Modules are already imported so can not be re-written: testinfra
============================================= 4 passed, 1 pytest-warnings in 0.66 seconds ======================================================
```

More information on **testinfra** can be found at https://github.com/philpep/testinfra

#### Salt Pillar Data

Example pillar data can be found [here](https://github.com/wicksy/laptop-build/blob/master/salt/README.md).

#### Ansible Variables

Example variables can be found [here](https://github.com/wicksy/laptop-build/blob/master/ansible/README.md).
