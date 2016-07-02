{%- if salt['pillar.get']('sshkeys') %}
  {%- for user, config in salt['pillar.get']('sshkeys').iteritems() %}
sshkey-{{ user }}-managed:
    {%- if config['present'] %}
  ssh_auth.present:
    - user: {{ user }}
    - enc: {{ config['enc'] }}
    - name: {{ config['key'] }}
    - comment: {{ config['comment'] }}
    - require:
      - sls: users
    {%- else %}
  ssh_auth.absent:
    - user: {{ user }}
    - name: {{ config['key'] }}
    - require:
      - sls: users
    {%- endif %}
  {% endfor %}
{%- endif %}

sshkey-root-managed:
  file.absent:
    - name: /root/.ssh/authorized_keys
