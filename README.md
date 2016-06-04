## Salt and Bash to help rebuild my laptops

#### Ubuntu 15.10 on Dell Inspiron

* Obtain and run a copy of the following script to configure the wifi adapter:

```
$ https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ubuntu/inspiron/bootwifi.sh
```

* Download and run the bootstrap:

```
$ /usr/bin/curl -L https://raw.githubusercontent.com/wicksy/laptop-build/master/bin/ubuntu/generic/bootstrap.sh | /usr/bin/sudo /bin/bash
```

* Run a local Salt highstate

```
$ /usr/bin/sudo salt-call --local -l debug state.highstate
```
