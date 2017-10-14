gitsemver-github:
  git.latest:
    - name: https://github.com/markchalloner/git-semver.git
    - branch: master
    - user: wicksy
    - target: /git/wicksy/git-semver
    - require:
      - file: dotfiles-directory
      - sls: pkg

gitsemver-install:
  cmd.run:
    - name: /git/wicksy/git-semver/install.sh
    - cwd: /git/wicksy/git-semver/
    - runas: root
    - unless: test -f /usr/local/bin/git-semver

gitsemver-config:
  file.directory:
    - name: /home/wicksy/.git-semver
    - user: wicksy
    - group: wicksy
    - mode: 755
    - recurse:
      - user
      - group
    - require:
        - git: gitsemver-github
