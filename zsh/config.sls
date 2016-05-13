{% for user in ['root', 'arx'] %}
{% for file in ['.zshrc', '.zprofile', '.zshenv'] %}
{{ salt['user.info'](user).home }}/{{ file }}:
  file.managed:
    - user: {{ user }}
    - group: {{ salt['user.info'](user).gid }}
    - mode: 600
    - source:
      - salt://{{ sls }}/{{ file }}-{{ grains['fqdn'] }}-{{ user }}
      - salt://{{ sls }}/{{ file }}-{{ grains['os'] }}-{{ user }}
      - salt://{{ sls }}/{{ file }}-{{ grains['fqdn'] }}
      - salt://{{ sls }}/{{ file }}-{{ grains['os'] }}
      - salt://{{ sls }}/{{ file }}-{{ user }}
      - salt://{{ sls }}/{{ file }}
    - require:
      - sls: users
{% endfor %}

{{ salt['user.info'](user).home }}/.config/functions:
  file.recurse:
    - user: {{ user }}
    - group: {{ salt['user.info'](user).gid }}
    - file.recurse: 600
    - dir_mode: 700
    - recurse: true
    - source:
      - salt://{{ sls }}/functions-{{ grains['fqdn'] }}-{{ user }}
      - salt://{{ sls }}/functions-{{ grains['os'] }}-{{ user }}
      - salt://{{ sls }}/functions-{{ grains['fqdn'] }}
      - salt://{{ sls }}/functions-{{ grains['os'] }}
      - salt://{{ sls }}/functions-{{ user }}
      - salt://{{ sls }}/functions
    - require:
      - sls: users
{% endfor %}
