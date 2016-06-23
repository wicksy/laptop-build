{%- if salt['pillar.get']('pkg:installed') %}
pkg-installed:
  pkg.latest:
    - pkgs:
  {%- for pkg in salt['pillar.get']('pkg:installed') %}
      - {{ pkg }}
  {% endfor %}
{%- endif %}
