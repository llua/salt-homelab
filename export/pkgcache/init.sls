install squid:
  pkg.installed:
    - name: squid

"manage squid's config file":
  file.managed:
    - name: /usr/local/etc/squid/squid.conf
    - source: salt://pkgcache/files/squid.conf
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - defaults:
        visible_hostname: {{ grains['fqdn'] }}
        cache_dir_size: 20480

"create squid's cache directory":
  cmd.run:
    - name: 'squid -z --foreground >/dev/null 2>&1'
    - creates:
      - /var/squid/cache/00

manage squid service:
  service.running:
    - name: squid
    - enable: True
    - refresh: True
    - watch:
      - file: /usr/local/etc/squid/squid.conf
