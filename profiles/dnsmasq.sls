{% set osmap = salt['grains.filter_by']({
  'FreeBSD': {
    'etc':  '/usr/local/etc',
    'user': 'nobody',
  },
  'Default': {
    'etc':  '/etc',
    'user': 'dnsmasq',
  },
}, grain='os', default='Default') %}
include:
  - dnsmasq

dnsmasq_config_leases_directory:
  file.directory:
    - name: {{ osmap.etc }}/dnsmasq.d/lease
    - user: {{ osmap.user }}
    - group: {{ osmap.user }}
    - makedirs: True
    - mode: 0755

dnsmasq_config_addn_hosts_directory:
  file.directory:
    - name: {{ osmap.etc }}/dnsmasq.d/addn-hosts
    - user: {{ osmap.user }}
    - group: {{ osmap.user }}
    - makedirs: True
    - mode: 0755

dnsmasq_hosts_file_someonewhocares:
  file.managed:
    - name: {{ osmap.etc }}/dnsmasq.d/addn-hosts/someonewhocares
    - user: {{ osmap.user }}
    - group: {{ osmap.user }}
    - makedirs: True
    - mode: 0644
    # I don't care about contents of the page
    - contents: {{ ("https://someonewhocares.org/hosts/hosts" | http_query).body | yaml_encode }}
    - watch_in:
        - service: dnsmasq
