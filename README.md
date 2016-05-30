## Salt and Bash to help rebuild my laptops

* ubuntu/inspiron - Rebuild Dell Inspiron N15 booted from Ubuntu 15.10 Minimal Server ISO

#### Ubuntu 15.10 on Dell Inspiron

* Obtain and run a copy of the following script to configure the wifi adapter:

```
$ https://raw.githubusercontent.com/wicksy/laptop-build/master/ubuntu/inspiron/bin/bootwifi.sh
```

* Download and run the bootstrap:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/ubuntu/inspiron/bin/bootstrap.sh | /usr/bin/sudo /bin/bash
```

* Run a local Salt highstate

```
$ /usr/bin/sudo salt-call --local -l debug state.highstate
```
