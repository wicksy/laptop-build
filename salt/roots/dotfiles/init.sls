dotfiles-directory:
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

dotgiles-github:
  git.latest:
    - name: git@github.com:wicksy/configfiles.git
    - branch: master
    - user: root
    - target: /git/wicksy/configfiles
    - require:
      - file: dotfiles-directory

{%- for user in ['root','wicksy'] %}
  {%- for file in ['.vimrc', '.vim', '.bashrc'] %}
dotfiles-{{ user }}-{{ file }}-link:
  file.symlink:
    {%- if user == "root" %}
    - name: /{{ user }}/{{ file }}
    {%- else %}
    - name: /home/{{ user }}/{{ file }}
    {%- endif %}
    - target: /git/wicksy/configfiles/dotfiles/{{ file }}
    - force: True
    - user: wicksy
    - group: wicksy
    - mode: 644
    - require:
      - sls: users
  {% endfor %}
{% endfor %}
