{% if grains['os'] == 'FreeBSD' %}
  {% set package = 'openntpd' %}
{% else %}
  {% set package = 'ntp' %}
{% endif %}

ntp-install:
  pkg.installed:
    - name: '{{ package }}'

{% if package == 'openntpd' %}
disable ntpd, for openntpd:
  service.disabled:
    - name: ntpd

stop ntpd, for openntpd:
  service.dead:
    - name: ntpd
{% endif %}
