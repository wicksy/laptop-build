atom-repo:
  pkgrepo.managed:
    - humanname: Atom Editor
    - name: deb [arch={{ grains['osarch'] }}] http://ppa.launchpad.net/webupd8team/atom/ubuntu {{ grains['oscodename'] }} main
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/ppa_launchpad_net_webupd8team_atom_ubuntu.list
    - gpgcheck: 1
    - keyid: EEA14886
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: atom-pkg

atom-pkg:
  pkg.installed:
    - pkgs:
      - atom
    - require:
      - pkgrepo: atom-repo
      - sls: pip
      - sls: pkg
