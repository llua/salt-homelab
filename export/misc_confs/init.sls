include:
  - .homedir
{% if grains.kernel == 'FreeBSD' %}
  - .periodic
  - .loader
{% endif %}
