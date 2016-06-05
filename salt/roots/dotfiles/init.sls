dotfiles-directory:
  file.directory:
    - user: wicksy
    - group: wicksy
    - mode: 755
    - makedirs : True
    - require:
      - sls: users
    - names:
      - /home/wicksy/git
      - /home/wicksy/git/configfiles

dotgiles-github:
  git.latest:
    - name: https://github.com/wicksy/configfiles.git
    - branch: master
    - user: wicksy
    - target: /home/wicksy/git/configfiles
    - require:
      - file: dotfiles-directory

{%- for user in ['root','wicksy'] %}
  {%- for file in ['.vimrc','.bashrc'] %}
dotfiles-{{ user }}-{{ file }}-link:
  file.symlink:
    {%- if user == "root" %}
    - name: /{{ user }}/{{ file }}
    {%- else %}
    - name: /home/{{ user }}/{{ file }}
    {%- endif %}
    - target: /home/wicksy/git/configfiles/dotfiles/{{ file }}
    - force: True
    - user: wicksy
    - group: wicksy
    - mode: 644
  {% endfor %}
{% endfor %}
