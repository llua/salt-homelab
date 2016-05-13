salt-minion:
  pkg.installed:
    - name: py27-salt
  service.running:
    - name: salt_minion
    - watch:
      - pkg: py27-salt
      - file: /usr/local/etc/salt/minion.d

service-enabled:
  service.enabled:
    - name: salt_minion
    - require:
      - pkg: py27-salt

/usr/local/etc/salt/minion.d:
  file.recurse:
    - source: salt://salt-minion/files/minion.d/
    - file_mode: 640
    - dir_mode: 750
    - recurse: true
    - user: root
    - group: 0
