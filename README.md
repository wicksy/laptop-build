## Salt, Ansible and Bash to help rebuild my laptops

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
