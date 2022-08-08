musicpd:
  pkg.installed:
  - name: musicpd
  service.running:
  - enable: True
  - require:
    - pkg: musicpd
  - watch:
    - file: Manage /usr/local/etc/musicpd.conf

Manage /usr/local/etc/musicpd.conf:
  file.managed:
    - name: /usr/local/etc/musicpd.conf
    - source: salt://mpd/mpd.conf.j2
    - user: mpd
    - group: mpd
    - mode: 640
    - template: jinja
    - defaults:
        config: {{ salt['pillar.get']('mpd') }}
