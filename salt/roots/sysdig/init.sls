sysdig-key:
  cmd.run:
    - name: curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | apt-key add -

sysdig-repo:
  cmd.run:
    - name: curl -s -o /etc/apt/sources.list.d/draios.list http://download.draios.com/stable/deb/draios.list

sysdig-pkg:
  pkg.installed:
    - pkgs:
      - linux-headers-{{ grains['kernelrelease'] }}
      - sysdig
    - require:
      - cmd: sysdig-key
      - cmd: sysdig-repo
      - sls: pkg
