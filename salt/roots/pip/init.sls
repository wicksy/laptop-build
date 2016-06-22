{%- if salt['pillar.get']('pip:installed') %}
  {%- for pip in salt['pillar.get']('pip:installed') %}
pip-{{ pip }}-installed:
  pip.installed:
    - name: {{ pip }}
    - upgrade: True
    - require:
      - sls: pkg
    - require_in:
      - cmd: pip-reload-modules
  {% endfor %}
{%- endif %}

pip-reload-modules:
  cmd.run:
    - name: /bin/true
    - reload_modules: True
