{% for user in pillar.get('personal_dotfiles', {}) %}
{% if user in salt['user.list_users']() %}
{{ sls }}_{{ salt['user.info'](user).home }}/.pryrc:
  file.managed:
    - name: {{ salt['user.info'](user).home }}/.pryrc
    - source: salt://misc_confs/files/pryrc
    - user: {{ user }}
    - group: {{ salt['user.info'](user).gid }}
    - mode: 640
{% endif  %}
{% endfor %}
