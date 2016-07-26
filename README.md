## Salt, Ansible and Bash to help rebuild my laptops

#### Ubuntu on Dell Inspiron (tested with Ubuntu 14 and 15)

* Obtain and run a copy of the following script to configure the wifi adapter:

```
$ https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ubuntu/inspiron/bootwifi.sh
```

* To configure the laptop using Salt:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ubuntu/generic/salt/bootstrap.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/sudo salt-call --local -l debug state.highstate
```

* To configure the laptop using Ansible:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ubuntu/generic/ansible/bootstrap.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/sudo -H -u ansible /bin/bash -c "cd /srv/ansible && /usr/bin/ansible-playbook -i hosts site.yml -vv"
```
