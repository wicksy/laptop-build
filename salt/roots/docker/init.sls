docker-key:
  cmd.run:
    - name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

docker-repo:
  pkgrepo.managed:
    - humanname: Docker Project
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - require_in:
      - pkg: docker-pkg

docker-pkg:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - software-properties-common
      - docker-ce
    - require:
      - pkgrepo: docker-repo
      - cmd: docker-key
      - sls: pip
      - sls: pkg

docker-service:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: docker-pkg
