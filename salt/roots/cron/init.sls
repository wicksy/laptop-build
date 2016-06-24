{% from "cron/map.jinja" import cronjobs with context %}

crontab-path:
  cron.env_present:
    - name: PATH
    - value: "/usr/local/bin:/usr/bin:/bin"

{% for index in cronjobs['jobs'] %}

  {% if cronjobs['jobs'][index]['enabled'] %}

cronjob-present-{{index}}:
  cron.present:
    - name: {{ cronjobs['jobs'][index]['command'] }}
    - identifier: cronjob-{{cronjobs['jobs'][index]['user']}}-{{index}}
    - user: {{ cronjobs['jobs'][index]['user'] }}
    - hour: {{ cronjobs['jobs'][index]['hour']|default('2') }}
    - minute: {{ cronjobs['jobs'][index]['minute']|default('random') }}
    - daymonth: {{ cronjobs['jobs'][index]['daymonth']|default("'*'") }}
    - month: {{ cronjobs['jobs'][index]['month']|default("'*'") }}
    - dayweek: {{ cronjobs['jobs'][index]['dayweek']|default("'*'") }}
    - require:
      - sls: users

  {% else %}

cronjob-absent-{{index}}:
  cron.absent:
    - identifier: cronjob-{{cronjobs['jobs'][index]['user']}}-{{index}}
    - user: {{ cronjobs['jobs'][index]['user'] }}
    - require:
      - sls: users

  {% endif %}

{% endfor %}