## Salt, Ansible and Bash to help rebuild my laptops

#### Installation

Tested on the following:

* Dell Inspiron running Ubuntu 15
* Dell Inspiron running Ubuntu 14

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
$ /usr/bin/sudo -H -u ansible /bin/bash -c "cd /srv/ansible && /usr/bin/ansible-playbook -i hosts site.yml -vv"
```

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

