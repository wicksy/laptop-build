{%- if salt['pillar.get']('users') %}
  {%- for user, config in salt['pillar.get']('users').iteritems() %}
users-{{ user }}-managed:
    {%- if config['present'] %}
  user.present:
    - name: {{ user }}
    - password: {{ config['password'] }}
    - fullname: {{ config['fullname'] }}
    - home: {{ config['home'] }}
    - createhome: True
    - shell: {{ config['shell'] }}
    - optional_groups: {{ config['groups'] }}
    {%- else %}
  user.absent:
    - name: {{ user }}
    {%- endif %}
  {% endfor %}
{%- endif %}
