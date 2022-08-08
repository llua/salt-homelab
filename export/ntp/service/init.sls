{% if grains['os'] == 'FreeBSD' %}
  {% set service = 'openntpd' %}
{% elif grains['os_family'] == 'Debian' %}
  {% set service = 'ntp' %}
{% else %}
  {% set service = 'ntpd' %}
{% endif %}

ntp-enable:
  service.enabled:
    - name: '{{ service }}'
    - require:
      - sls: ntp.config

ntp-running:
  service.running:
    - name: '{{ service }}'
    - watch:
      - sls: ntp.config
    - require:
      - sls: ntp.config
