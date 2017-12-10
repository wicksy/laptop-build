slack-remove-tmpfile:
  file.absent:
    - name: /tmp/slack.deb

slack-download:
  cmd.run:
    - name: wget -O /tmp/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.9.0-amd64.deb
    - require:
      - file: slack-remove-tmpfile

slack-prereq-install:
  pkg.installed:
    - pkgs:
      - gir1.2-gnomekeyring-1.0
      - libappindicator1
      - libgnome-keyring0

slack-install:
  cmd.run:
    - name: dpkg -i /tmp/slack.deb
    - require:
      - sls: pkg
      - pkg: slack-prereq-install
      - cmd: slack-download

slack-clean-tmpfile:
  file.absent:
    - name: /tmp/slack.deb
    - require:
      - cmd: slack-install