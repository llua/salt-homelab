include:
  - salt.minion
  - packages
  - zsh
  - vim
  - users
  - openssh
  - openssh.config
  - sudoers
  - misc_confs
{% if grains['kernel'] == 'Linux' %}
  - openssh.client
  {% if grains['os'] == 'AlmaLinux' %}
  - epel
  {% endif %}
  {% if grains['linux_lxc'] == false and grains['virtual'] != 'systemd-nspawn' %}
  - chrony
  - sysctl.param
  {% endif %}
{% endif %}
{% if grains['kernel'] == 'FreeBSD' %}
  - freebsd-update
  - syslogd
  - stop_sendmail
  {% if grains['freebsd_jailed'] == false %}
  - ntp
  - sysctl.param
  {% endif %}
{% endif %}
  - postfix
  - postfix.config
