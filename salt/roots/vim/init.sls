{%- if salt['pillar.get']('vim:plugins') %}
  {%- for user in ['wicksy'] %}
    {%- for plugin in salt['pillar.get']('vim:plugins') %}
vim-{{ user }}-remove-{{ plugin }}:
  cmd.run:
    - name: vim-addons remove {{ plugin }}
    - runas: {{ user }}
    - require:
      - sls: pkg
      - sls: users
vim-{{ user }}-install-{{ plugin }}:
  cmd.run:
    - name: vim-addons install {{ plugin }}
    - runas: {{ user }}
    - require:
      - sls: pkg
      - sls: users

    {% endfor %}

vim-{{ user }}-vundle-repo:
  git.latest:
    - name: https://github.com/VundleVim/Vundle.vim.git
    - branch: master
    - user: {{ user }}
    - target: /home/{{ user }}/.vim/bundle/Vundle.vim
    - require:
      - sls: pkg
      - sls: users
vim-{{ user }}-vundle-plugins:
  cmd.run:
    - name: vim +PluginInstall +qall
    - runas: {{ user }}
    - require:
      - sls: pkg
      - sls: users
vim-{{ user }}-chown:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - recurse:
      - user
      - group
    - names:
      - /home/{{ user }}/.vim

  {% endfor %}
{% endif %}
