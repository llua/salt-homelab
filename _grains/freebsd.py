#!/usr/bin/env python2
def freebsd_jailed():
  import platform
  import salt.modules.cmdmod

  __salt__ = {
               'cmd.run_stdout': salt.modules.cmdmod.run_stdout
             }
    grains = { 'freebsd_jailed': False }

  if 'FreeBSD' in platform.uname():
    if int(__salt__['cmd.run_stdout'](
        'sysctl -n security.jail.jailed',
        output_loglevel='trace')) == 1:

      grains['freebsd_jailed'] = True
  return grains
