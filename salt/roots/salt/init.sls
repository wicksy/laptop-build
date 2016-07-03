salt-service-disabled:
  service.disabled:
    - name: salt-minion
salt-service-dead:
  service.dead:
    - name: salt-minion

salt-minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://salt/templates/minion
    - user: root
    - group: root
    - mode: 644
    - template: jinja

salt-directories:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
    - names:
      - /git
      - /git/wicksy
      - /srv/formulas

salt-github:
  git.latest:
    - name: git@github.com:wicksy/laptop-build.git
    - branch: master
    - user: root
    - target: /git/wicksy/laptop-build
    - require:
      - file: salt-directories

{%- if salt['pillar.get']('salt:formulas') %}
  {%- for formula, config in salt['pillar.get']('salt:formulas').iteritems() %}
salt-{{ formula }}-formula:
  git.latest:
    - name: {{ config.git }}
    - branch: master
    - user: root
    - target: /srv/formulas/{{ formula }}-formula
    - require:
      - file: salt-directories
  {% endfor %}
{% endif %}
