#!/usr/bin/env python2
def freebsd_jailed():
  import platform
  from subprocess import check_output
  grains = { 'freebsd_jailed': False }
  if 'FreeBSD' in platform.uname():
    if int(check_output('sysctl -n security.jail.jailed',shell=True)) == 1:
      grains['freebsd_jailed'] = True
  return grains
