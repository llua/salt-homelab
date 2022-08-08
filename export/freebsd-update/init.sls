Manage /etc/freebsd-update.conf:
  file.managed:
    - name: /etc/freebsd-update.conf
    - source: salt://freebsd-update/freebsd-update.conf.j2
    - user: root
    - group: wheel
    - mode: 644
    - template: jinja
    - defaults:
        config: {{ salt['pillar.get']('freebsd-update') }}
