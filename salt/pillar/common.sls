cronjobs:
  jobs:
    testjob:
      enabled: True
      command: "echo $(date)"
      user: wicksy
      hour: 12
      minute: 30
      daymonth: "'*'"
      month: "'*'"
      dayweek: "'*'"

ntp:
  servers:
    - 0.pool.ntp.org
    - 1.pool.ntp.org
    - 2.pool.ntp.org
    - 3.pool.ntp.org

pip:
  installed:
    - pip==8.1.1
    - awscli
    - boto3
    - docker-py==1.7.2
    - gitpython
    - mkdocs
    - pep8
    - virtualenv
    - virtualenvwrapper

pkg:
  installed:
    - apt-file
    - blktrace
    - chromium-browser
    - curl
    - diod
    - fonts-font-awesome
    - git
    - gnupg
    - handbrake
    - handbrake-cli
    - htop
    - i3
    - iotop
    - language-pack-en-base
    - laptop-mode-tools
    - nfs-common
    - ntop
    - openssl
    - python
    - python-pip
    - suckless-tools
    - sysstat
    - tree
    - vagrant
    - vim
    - virtualbox
    - vlc
    - wget
    - whois
    - x11-xserver-utils
    - x264
    - xfce4-terminal
    - xfonts-terminus
    - xinit
{% if grains['osmajorrelease'] in ['14', '15'] %}
    - atsar
{% endif %}
{% if grains['osmajorrelease'] in ['16'] %}
    - fonts-powerline
    - rofi
{% endif %}

sshd_config:
  Port: 22
  Protocol: 2
  HostKey:
    - /etc/ssh/ssh_host_rsa_key
    - /etc/ssh/ssh_host_dsa_key
    - /etc/ssh/ssh_host_ecdsa_key
    - /etc/ssh/ssh_host_ed25519_key
  UsePrivilegeSeparation: yes
  KeyRegenerationInterval: 3600
  ServerKeyBits: 1024
  SyslogFacility: AUTH
  LogLevel: INFO
  LoginGraceTime: 120
  PermitRootLogin: no
  StrictModes: yes
  RSAAuthentication: yes
  PubkeyAuthentication: yes
  IgnoreRhosts: yes
  RhostsRSAAuthentication: no
  HostbasedAuthentication: no
  PermitEmptyPasswords: no
  ChallengeResponseAuthentication: no
  PasswordAuthentication: yes
  X11Forwarding: yes
  X11DisplayOffset: 10
  PrintMotd: no
  PrintLastLog: yes
  TCPKeepAlive: yes
  AcceptEnv: LANG LC_*
  Subsystem: sftp /usr/lib/openssh/sftp-server
  UsePAM: yes

sshkeys:
  wicksy:
    present: True
    enc: ssh-rsa
    key: AAAAB3NzaC1yc2EAAAABIwAAAQEAnEIpXFliJ8TUvNEYRD7yrE1XbI/h5SFNvC+adOJ3rmwyFncUwQU4OUDMCqq45vc4mei6LzuO1bUH7sQkZaD+0QX5f6KvJlDkWIJaRlB7/rQxBr01incMyEzo1Xxsmarz4wv2IiROy7KnKP4VaDvFScUF8c/DyaStyj2BeV32rLiIwFI2l9LOHSy94sT9Bj5Ef+uTtGeO5ptWW89i/bo/IaB6ah7Hkk+NC8OplPJieEdzIkODLXZvwTon6NkcADIncrRA/8vpc3GxoCmyHdNPZp/facgHv9a7up2vXvEa6QWdLQwQqHDhsSOR2a9TxRTGKclrRsfBdXPd+i5dI+uC/Q==
    comment: MacBookPro

users:
  wicksy:
    present: True
    fullname: Martin Wicks
    password: $6$Mdjwh64Sncg381dd$RyXJ6VOfBbKUqPBmdLSPIgcWWfOR0r4CZW3Dkvr0TDP/hQPr9PK8lTkfdASOBwyrB0IT2mp3MAJsrwd2MMcSM0
    home: /home/wicksy
    shell: /bin/bash
    groups:
      - sudo
      - docker

