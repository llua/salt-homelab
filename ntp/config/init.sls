{% if grains['os'] == 'FreeBSD' %}
  {% set group = 'wheel' %}
  {% set file  = '/usr/local/etc/ntpd.conf' %}
{% else %}
  {% set group = 'ntp' %}
  {% set file  = '/etc/ntp.conf' %}
{% endif %}

ntp-config:
  file.managed:
    - name: '{{ file }}'
    - source: salt://ntp/config/ntp.conf-{{ grains['os_family'] }}
    - mode: 640
    - user: root
    - group: '{{ group }}'
    {% if grains['os'] != 'FreeBSD' %}
    - require:
      - sls: ntp.install
    {% endif %}
