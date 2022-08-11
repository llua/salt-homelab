"{{saltenv}}":
  '*':
    {% for profile in salt['pillar.get']('profiles', []) %}
    - profiles.{{ profile }}
    {% endfor %}
