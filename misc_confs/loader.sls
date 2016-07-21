{{ sls }}_/boot/loader.conf:
  file.managed:
    - name: /boot/loader.conf
    - source: salt://misc_confs/files/loader.conf.jinja
    - user: root
    - group: wheel
    - mode: 644
    - template: jinja
