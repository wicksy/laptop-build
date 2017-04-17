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
users-{{ user }}-lockhome:
  file.directory:
    - name: {{ config['home'] }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 750
    {%- for removedir in ['.i3', 'Desktop', 'Documents', 'Downloads', 'Music', 'Pictures', 'Public', 'Templates', 'Videos'] %}
users-{{ user }}-remove-{{ removedir }}:
  file.absent:
    - name: {{ config['home'] }}/{{ removedir }}
    {% endfor %}
  {% endfor %}
{%- endif %}
