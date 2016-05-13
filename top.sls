base:
  '*':
    - packages
    - users
    - openssh
  'kernel:Linux':
    - match: grain
    - openssh.client
  'kernel:FreeBSD':
    - match: grain
    - periodic
  '*.template.com or *[.-]test or *.container.net or *.test.com':
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
