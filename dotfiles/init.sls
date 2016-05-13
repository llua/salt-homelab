# vi: set ft=yaml.jinja :
{% for user in ['root', 'llua'] %}
{{ user }}-config:
  include:
    - .zsh
{% endfor %}
