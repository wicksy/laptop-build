{%- if salt['pillar.get']('vim:plugins') %}
  {%- for plugin in salt['pillar.get']('vim:plugins') %}
    {%- for user in ['root','wicksy'] %}
vim-{{ user }}-plugin-{{ plugin }}:
  cmd.run:
    - name: vim-addons install {{ plugin }}
    - runas: {{ user }}
    - require:
      - sls: dotfiles
      - sls: pkg
      - sls: users
    {% endfor %}
  {% endfor %}
{% endif %}