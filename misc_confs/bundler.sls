{% for user in pillar.get('personal_dotfiles', {}) %}
{% if user in salt['user.list_users']() %}
{{ sls }}_{{ salt['user.info'](user).home }}/.bundle:
  file.recurse:
    - name: {{ salt['user.info'](user).home }}/.bundle
    - user: {{ user }}
    - group: {{ salt['user.info'](user).gid }}
    - file.recurse: 600
    - dir_mode: 700
    - recurse: true
    - clean: true
    - template: jinja
    - source:
      - salt://misc_confs/files/bundler
{% endif  %}
{% endfor %}
