vagrant-directory:
  file.directory:
    - user: wicksy
    - group: wicksy
    - mode: 755
    - names:
      - /home/wicksy/vagrant
    - require:
      - sls: users

vagrant-file:
  file.symlink:
    - name: /home/wicksy/vagrant/Vagrantfile
    - target: /git/wicksy/configfiles/vagrant/Vagrantfile
    - force: True
    - user: wicksy
    - group: wicksy
    - mode: 644
    - require:
      - file: vagrant-directory
