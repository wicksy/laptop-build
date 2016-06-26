entropy-pkg:
  pkg.latest:
    - pkgs:
      - haveged

entropy-service:
  service.running:
    - name: haveged
    - enable: True
    - require:
      - pkg: entropy-pkg