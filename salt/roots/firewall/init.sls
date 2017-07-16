firewall-pkg:
  pkg.installed:
    - pkgs:
      - firewalld
    - require:
      - sls: pkg

firewall-service:
  service.running:
    - enable: True
    - name: firewalld
    - require:
      - pkg: firewall-pkg

{%- if salt['pillar.get']('firewall') %}
firewall-services:
  firewalld.present:
    - name: public
    - services:
  {%- for service in salt['pillar.get']('firewall') %}
      - {{ service }}
  {% endfor %}
{% endif %}
