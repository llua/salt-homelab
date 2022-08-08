include:
  - salt.minion
  - packages
  - zsh
  - vim
  - users
  - openssh
  - openssh.config
  - sudoers
{% if grains['kernel'] == 'Linux' %}
  - openssh.client
  {% if grains['os'] == 'CentOS' %}
  - epel
  {% endif %}
  {% if grains['linux_lxc'] == false and grains['virtual'] != 'systemd-nspawn' %}
  - chrony
  - sysctl.param
  {% endif %}
{% endif %}
{% if grains['kernel'] == 'FreeBSD' %}
  - misc_confs
  - freebsd-update
  {% if grains['freebsd_jailed'] == false %}
  - ntp
  - sysctl.param
  {% endif %}
{% endif %}
