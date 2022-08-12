{% if grains['os'] == 'FreeBSD' %}
set up proxy for pkg:
  file.managed:
    - name: /usr/local/etc/pkg.conf
    - source: salt://packages/files/pkg.conf
    - user: root
    - group: wheel
    - mode: 644
{% endif %}

base_packages:
  pkg.installed:
    - pkgs: {{ pillar['packages'] }}
