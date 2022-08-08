{{ sls }}_/etc/periodic.conf:
  file.managed:
    - name: /etc/periodic.conf
    - source: salt://misc_confs/files/periodic.conf.jinja
    - user: root
    - group: wheel
    - mode: 644
    - template: jinja
