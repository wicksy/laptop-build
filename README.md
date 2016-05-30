#### Salt and Bash to help rebuild my laptops

* ubuntu/inspiron - Rebuild Dell Inspiron N15 booted from Ubuntu 15.10 Minimal Server ISO

## Ubuntu 15.10 on Dell Inspiron

```
$ /usr/bin/curl -L https://github.com/wicksy/laptop-build/blob/master/ubuntu/inspiron/bin/bootwifi.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/curl -L https://github.com/wicksy/laptop-build/blob/master/ubuntu/inspiron/bin/bootstrap.sh | /usr/bin/sudo /bin/bash
$ /usr/bin/sudo salt-call --local -l debug state.highstate
```
