gpg-batch-file:
  file.managed:
    - name: /tmp/gpg.batch
    - source: salt://gpg/templates/gpg.batch
    - owner: wicksy
    - group: wicksy
    - mode: 600
    - template: jinja
    - require:
      - sls: pkg
      - sls: users

gpg-keys-wicksy:
  cmd.run:
    - name: gpg2 --batch --gen-key /tmp/gpg.batch
    - runas: wicksy
    - unless: test -d /home/wicksy/.gnupg/
    - require:
      - file: gpg-batch-file

gpg-remove-batch:
  file.absent:
    - name: /tmp/gpg.batch
