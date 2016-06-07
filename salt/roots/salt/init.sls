salt-service-disabled:
  service.disabled:
    - name: salt-minion
salt-service-dead:
  service.dead:
    - name: salt-minion

salt-directories:
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

salt-github:
  git.latest:
    - name: git@github.com:wicksy/laptop-build.git
    - branch: master
    - user: root
    - target: /git/wicksy/laptop-build
    - require:
      - file: salt-directories

