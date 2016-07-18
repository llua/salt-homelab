/etc/periodic.conf:
  file.managed:
    - source: salt://{{ sls }}/periodic.jinja
    - user: root
    - group: wheel
    - mode: 644
    - template: jinja
