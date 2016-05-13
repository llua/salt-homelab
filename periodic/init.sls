/etc/periodic.conf:
  ini.options_present: {{ salt['pillar.get']('periodic_conf', {}) }}
