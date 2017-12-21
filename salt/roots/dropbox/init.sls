dropbox-remove-tmpfile:
  file.absent:
    - name: /tmp/dropbox.deb

dropbox-download:
  cmd.run:
    - name: wget --no-verbose -O /tmp/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
    - require:
      - file: dropbox-remove-tmpfile

dropbox-install:
  pkg.installed:
    - sources:
      - dropbox: /tmp/dropbox.deb
    - require:
      - sls: pkg
      - cmd: dropbox-download

dropbox-clean-tmpfile:
  file.absent:
    - name: /tmp/dropbox.deb
    - require:
      - pkg: dropbox-install