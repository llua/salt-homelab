{% if grains['os'] == 'FreeBSD' %}
set up proxy for pkg:
  file.managed:
    - name: /usr/local/etc/pkg.conf
    - source: salt://packages/files/pkg.conf
    - user: root
    - group: wheel
    - mode: 644

use regular http for proxy cache:
  file.managed:
    - name: /usr/local/etc/pkg/repos/FreeBSD.conf
    - source: salt://packages/files/FreeBSD.conf
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - makedirs: True
{% endif %}

base_packages:
  pkg.installed:
    - pkgs: {{ pillar['packages'] }}
