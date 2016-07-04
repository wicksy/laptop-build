ssh-pkg:
  pkg.installed:
    - pkgs:
      - openssh-client
      - openssh-server
      - openssh-sftp-server
    - require:
      - sls: pkg

ssh-service:
  service.running:
    - enable: True
    - name: ssh
    - require:
      - pkg: ssh-pkg

ssh-sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://ssh/templates/sshd_config
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ssh-service