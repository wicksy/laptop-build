#### Ansible Variables

The following are examples of Ansible variables used by the roles:

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
