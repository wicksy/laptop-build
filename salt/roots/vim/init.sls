{%- for user in ['wicksy'] %}

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
