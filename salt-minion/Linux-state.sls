{% from "salt-minion/map.jinja" import map with context %}
salt-minion:
  pkg.installed:
    - name: {{ map.package }}
  service.running:
    - watch:
      - pkg: salt-minion
      - file: /etc/salt/minion.d
        
service-enabled:
  service.enabled:
    - name: {{ map.service }}
    - watch:
      - pkg: salt-minion

service-systemd:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/salt-minion.service.d

/etc/salt/minion.d:
  file.recurse:
    - recurse: True
    - source: salt://salt-minion/files/minion.d
    - file_mode: 644
    - dir_mode: 755
    - user: root
    - group: root

/etc/systemd/system/salt-minion.service.d:
  file.recurse:
    - recurse: True
    - source: salt://salt-minion/files/salt-minion.service.d
    - file_mode: 644
    - dir_mode: 755
    - user: root
    - group: root
