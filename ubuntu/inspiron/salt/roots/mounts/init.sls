mount-directories:
  file.directory:
    - user: root
    - group: root
    - mode: 750
    - makedirs : True
    - recurse:
      - user
      - group
      - mode
    - names:
      - /mnt/buffalo/a
      - /mnt/buffalo/b
      - /mnt/samsung/
      - /mnt/ds415plus/Dell-Inspiron
      - /mnt/ds415plus/Media
