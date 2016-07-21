{% if grains.kernel == 'FreeBSD' %}
  include:
    - .periodic
    - .loader
{% endif %}
