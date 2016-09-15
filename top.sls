base:
  '*':
    - packages
    - users
    - openssh
    - salt.minion
  'kernel:Linux':
    - match: grain
    - openssh.client
  'kernel:FreeBSD':
    - match: grain
    - misc_confs
  '*.template.com or *[.-]test or *.container.net or *.test.com or aida-* or *.local':
    - match: compound
    - zsh
    - vim
  '*.mac-anu.org':
    - zsh
    - vim
  'G@kernel:Linux and G@linux_lxc:false':
    - match: compound
    - ntp
  'G@os:FreeBSD and G@freebsd_jailed:false':
    - match: compound
    - ntp
