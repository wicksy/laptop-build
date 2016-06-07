{%- if salt['pillar.get']('git:config') %}
  {%- for user in salt['pillar.get']('git:config') %}
    {%- for item, config in salt['pillar.get']('git:config:' + user).iteritems() %}
git-{{ user }}-{{ item }}-config:
  git.config_set:
    - user: {{ user }}
    - name: {{ item }}
    - value: {{ config['value'] }}
    - global: {{ config['global'] }}
    - require:
      - sls: users
    {% endfor %}
  {% endfor %}
{%- endif %}
