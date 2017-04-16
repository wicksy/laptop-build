dotfiles-directory:
  file.directory:
    - user: wicksy
    - group: wicksy
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
    - user: wicksy
    - target: /git/wicksy/configfiles
    - require:
      - file: dotfiles-directory
      - sls: sshkeys

{%- for user in ['wicksy'] %}
  {%- for file in ['.aws', '.bashrc', '.config', '.gitconfig', '.ssh/config', '.vimrc'] %}
dotfiles-{{ user }}-{{ file }}-link:
  file.symlink:
    - name: /home/{{ user }}/{{ file }}
    - target: /git/wicksy/configfiles/dotfiles/{{ file }}
    - force: True
    - user: wicksy
    - group: wicksy
    - mode: 644
    - require:
      - sls: users
  {% endfor %}
{% endfor %}
