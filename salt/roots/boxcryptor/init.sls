boxcryptor-remove-tmpfile:
  file.absent:
    - name: /tmp/boxcryptor-portable.tar.gz

boxcryptor-download:
  cmd.run:
    - name: wget --no-verbose -O /tmp/boxcryptor-portable.tar.gz https://www.boxcryptor.com/l/download-linux-portable
    - require:
      - file: boxcryptor-remove-tmpfile

boxcryptor-directory:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - names:
      - /opt/
      - /opt/boxcryptor/

boxcryptor-install:
  archive.extracted:
    - name: /opt/boxcryptor/
    - source: /tmp/boxcryptor-portable.tar.gz
    - enforce_toplevel: False
    - user: root
    - group: root
    - require:
      - sls: pkg
      - file: boxcryptor-directory
      - cmd: boxcryptor-download

boxcryptor-clean-tmpfile:
  file.absent:
    - name: /tmp/boxcryptor-portable.tar.gz
    - require:
      - archive: boxcryptor-install