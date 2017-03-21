[![Build Status](https://travis-ci.org/wicksy/laptop-build.svg?branch=master)](https://travis-ci.org/wicksy/laptop-build) [![license](https://img.shields.io/badge/License-MIT-blue.svg?maxAge=2592000)](https://github.com/wicksy/laptop-build/blob/master/LICENSE.md)</br>

## Laptop Build Automation

#### Overview

![Saltstack logo](logos/saltstack.png "Saltstack")
![Ansible logo](logos/ansible.png "Ansible")

Salt and Ansible used to configure a number of Linux laptops that I currently use.

#### Tested Against

Tested on the following:

* Dell Inspiron running Ubuntu 16.04 (tested with Ansible only)
* Dell Inspiron running Ubuntu 15.10 (tested with Salt/Ansible)
* Dell Inspiron running Ubuntu 14.04 (tested with Salt only)
* Samsung Q45 running Ubuntu 14.04 (32-bit) (tested with Ansible only)

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
$ /usr/bin/sudo -H -u ansible /usr/bin/ansible-playbook --limit localhost -i /srv/ansible/hosts /srv/ansible/site.yml -vv"
```

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

The following section includes examples of Salt pillar data used by the states:

* cronjobs

```
cronjobs:
  jobs:
    testjob:
      enabled: True
      command: "echo $(date)"
      user: bob
      hour: 12
      minute: 30
      daymonth: "'*'"
      month: "'*'"
      dayweek: "'*'"
```

* git

```
git:
  config:
      bob:
        user.email:
          value: bob@gmail.com
          global: True
        user.name:
          value: Bob Smith
          global: True
        core.editor:
          value: vim
          global: True
```

* ntp

```
ntp:
  servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
    - 2.pool.ntp.org
    - 3.pool.ntp.org
```

* pip

```
pip:
  installed:
    - pip==8.1.1
    - awscli
    - boto3
    - docker-py==1.7.2
    - gitpython
```

* pkg

```
pkg:
  installed:
    - apt-file
    - atsar
    - blktrace
    - chromium-browser
    - curl
```

* sshd_config

```
sshd_config:
  Port: 22
  Protocol: 2
  HostKey:
    - /etc/ssh/ssh_host_rsa_key
    - /etc/ssh/ssh_host_dsa_key
    - /etc/ssh/ssh_host_ecdsa_key
    - /etc/ssh/ssh_host_ed25519_key
  UsePrivilegeSeparation: yes
```

* sshkeys

```
sshkeys:
  bob:
    present: True
    enc: ssh-rsa
    key: AAAAB3NzaC1yc2EAAAABIwAAAQEAnEIpXFliJ8TUvNEYRD7yrE1XbI/h5SFNvC+adOJ3rmwyFncUwQU4OUDMCqq45vc4mei6LzuO1bUH7sQkZaD+0QX5f6KvJlDkWIJaRlB7/rQxBr01incMyEzo1Xxsmarz4wv2IiROy7KnKP4VaDvFScUF8c/DyaStyj2BeV32rLiIwFI2l9LOHSy94sT9Bj5Ef+uTtGeO5ptWW89i/bo/T8dhanejYrkdhsncksay$3727dDJGNF96ugfsssFJfhfff//ff48fsaAnfhtt9934726dDFNHMTihknmdsRafjdkshhhananUUqSJVNGL784ejfl++4rjdb=ssjrhfXC/Q==
    comment: test ssh key
```

* users

```
users:
  bob:
    present: True
    fullname: Bob Smith
    password: $5+DDDmfjfnv48f6s$$rhf8RsnchatY68hY37shT59ghaXah48gkdschruf0Rtyhsbn8ds//dh48fnlsjhBsjayTwwLdotnc2MMfhfyeM0
    home: /home/bob
    shell: /bin/bash
    groups:
      - nginx
      - root
```

* vim

```
vim:
  plugins:
    - dockerfile
    - jinja
    - puppet
```

#### Ansible Variables

The following section includes examples of Ansible variables used by the roles:

* core_pkgs

```
core_pkgs:
  - apt-file
  - atsar
  - blktrace
  - chromium-browser
  - curl
```

* core_pips

```
core_pips:
  - pip==8.1.1
  - awscli
  - boto3
  - docker-py==1.7.2
  - gitpython
```

* cronjobs

```
cronjobs:
  testjob:
    name: Test
    state: present
    hour: 06
    minute: 11
    day: '*'
    user: wicksy
    job: "date > /tmp/date.out"
```

* gitconfig

```
gitconfig:
  user:
    email: bob@gmail.com
    name: Bob Smith
  core:
    editor: vim
```

* ntp

```
ntp:
  servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
    - 2.pool.ntp.org
    - 3.pool.ntp.org
```

* sshd_config

```
sshd_config:
  Port: 22
  Protocol: 2
  HostKey:
    - /etc/ssh/ssh_host_rsa_key
    - /etc/ssh/ssh_host_dsa_key
    - /etc/ssh/ssh_host_ecdsa_key
    - /etc/ssh/ssh_host_ed25519_key
  UsePrivilegeSeparation: yes
```

* sshkeys

```
sshkeys:
  bob:
    state: present
    key: ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAnEIpXFliJ8TUvNEYRD7yrE1XbI/h5SFNvC+adOJ3rmwyFncUwQU4OUDMCqq45vc4mei6LzuO1bUH7sQkZaD+0QX5f6KvJlDkWIJaRlB7/rQxBr01incMyEzo1Xxsmarz4wv2IiROy7KnKP4VaDvFScUF8c/DyaStyj2BeV32rLiIwFI2l9LOHSy94sT9Bj5Ef+uTtGeO5ptWW89i/bo/T8dhanejYrkdhsncksay$3727dDJGNF96ugfsssFJfhfff//ff48fsaAnfhtt9934726dDFNHMTihknmdsRafjdkshhhananUUqSJVNGL784ejfl++4rjdb=ssjrhfXC/Q== Testing Key
```

* users

```
users:
  bob:
    state: present
    comment: Bob Smith
    password: $5+DDDmfjfnv48f6s$$rhf8RsnchatY68hY37shT59ghaXah48gkdschruf0Rtyhsbn8ds//dh48fnlsjhBsjayTwwLdotnc2MMfhfyeM0
    groups:
      - sudo
      - docker
```

