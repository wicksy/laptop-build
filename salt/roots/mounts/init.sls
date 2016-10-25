mount-directories:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs : True
    - recurse:
      - user
      - group
      - mode
    - names:
      - /mnt/buffalo
      - /mnt/buffalo/a
      - /mnt/buffalo/b
      - /mnt/samsung/
      - /mnt/ds415plus
      - /mnt/ds415plus/Dell-Inspiron
      - /mnt/ds415plus/Media

mount-fstab:
  file.blockreplace:
    - name: /etc/fstab
    - marker_start: "# START section managed by Salt -DO-NOT-EDIT-"
    - marker_end: "# END section managed by Salt -DO-NOT-EDIT-"
    - content: |
        #
        # mount -t ntfs /dev/sdb5 /mnt/buffalo/a
        # mount -t ntfs /dev/sdc5 /mnt/buffalo/b
        # mount -t ntfs /dev/sdd1 /mnt/samsung
        # mount -t nfs ds415plus:/volume4/Dell-Inspiron /mnt/ds415plus/Dell-Inspiron
        # mount -t nfs ds415plus:/volume1/Media /mnt/ds415plus/Media
        #
    - append_if_not_found: True
    - backup: '.bak'
    - show_changes: True
