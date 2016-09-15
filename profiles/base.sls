include:
  - salt.minion
  - packages
  - users
  - openssh
  - zsh
  - vim
{% if grains['kernel'] == 'Linux' %}
  - openssh.client
  {% if grains['linux_lxc'] == false %}
  - ntp
  {% endif %}
{% endif %}
{% if grains['kernel'] == 'FreeBSD' %}
  - misc_confs
  {% if grains['freebsd_jailed'] == false %}
  - ntp
  {% endif %}
{% endif %}
{% if 'nexcess.net' not in grains['id'] %}
  - zsh
  - vim
{% endif %}
