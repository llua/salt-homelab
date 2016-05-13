ceph:
  pkg.installed

/etc/ceph:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - require:
      - pkg: ceph

/etc/ceph/ceph.conf:
  file.managed:
    - source: salt://ceph/ceph.conf-{{ grains['domain'] }}
    - mode: 600
    - user: root
    - group: root
    - require:
      - pkg: ceph

/etc/cron.daily/wb_cache_disable:
  file.managed:
    - source: salt://ceph/wb_cache_disable
    - mode: 700
    - user: root
    - group: root
    - require:
      - pkg: ceph
