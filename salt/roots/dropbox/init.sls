dropbox-remove-tmpfile:
  file.absent:
    - name: /tmp/dropbox.deb

dropbox-download:
  cmd.run:
    - name: wget -O /tmp/dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb

dropbox-install:
  pkg.installed:
    - sources:
      - dropbox: /tmp/dropbox.deb
    - require:
      - sls: pkg

dropbox-clean-tmpfile:
  file.absent:
    - name: /tmp/dropbox.deb