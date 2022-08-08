{% from "plexmediaserver/map.jinja" import plexmediaserver with context %}

Install python-augeas:
  pkg.installed:
    - name: py39-python-augeas

plexmediaserver:
  {% if plexmediaserver.pkg is defined %}
  pkg.installed:
    - name: {{ plexmediaserver.pkg }}
  {% if plexmediaserver.pkg_version is defined %}
    - version: {{ plexmediaserver.pkg_version }}
  {% endif %}
  {% endif %}


  {% if plexmediaserver.service_enable is sameas true %}
  service.running:
    - enable: {{ plexmediaserver.service_enable }}
    - name: {{ plexmediaserver.service_name }}
  {% if plexmediaserver.pkg is defined %}
    - require:
      - pkg: {{ plexmediaserver.pkg }}
  {% endif %}
  {% else %}
  service.dead:
    - enable: False
    - name: {{ plexmediaserver.service_name }}
  {% endif %}


  {% if plexmediaserver.preferences is defined %}
  # requires python-augeas to be installed
  augeas.change:
    - lens: xml.lns
    - context: '/files/usr/local/plexdata/Plex Media Server/Preferences.xml'
    - changes:
      {% for key, value in plexmediaserver.preferences.items() %}
      - set Preferences/#attribute/{{ key }} {{ value }}
      {% endfor %}
  {% if plexmediaserver.pkg is defined %}
    - require:
      - pkg: {{ plexmediaserver.pkg }}
  {% endif %}
  {% endif %}
