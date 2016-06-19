ntp:
  pkg.installed: []
  service.running:
    - watch:
      - file: /etc/ntp.conf

/etc/ntp.conf:
  file.managed:
    - source: salt://ntp/templates/ntp.conf
    - mode: 644
    - template: jinja
    - require:
      - pkg: ntp
