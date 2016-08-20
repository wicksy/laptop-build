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

dotfiles-github:
  git.latest:
    - name: https://github.com/wicksy/configfiles.git
    - branch: master
    - user: root
    - target: /git/wicksy/configfiles
    - require:
      - file: dotfiles-directory

{%- for user in ['root','wicksy'] %}
  {%- for file in ['.vimrc', '.bashrc'] %}
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
vim-{{ user }}-directory:
  file.directory:
  {%- if user == "root" %}
    - name: /{{ user }}/.vim
  {%- else %}
    - name: /home/{{ user }}/.vim
  {%- endif %}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - require:
      - sls: users
{% endfor %}
