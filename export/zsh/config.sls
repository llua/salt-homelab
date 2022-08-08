#!jinja | pyobjects
# vim: syn=python

users    = ['llua', 'root']
dotfiles = ['.zshrc', '.zprofile', '.zshenv']
__sls__  = '{{ sls }}'.strip('.config')

for user in users:
  for dotfile in dotfiles:
    File.managed('{0}/{1}'.format(salt.user.info(user)['home'],  dotfile),
      user   = user,
      group  = salt.user.info(user)['gid'],
      mode   = 600,
      source = [
        'salt://{0}/{1}-{2}-{3}'.format(__sls__, dotfile, grains('fqdn'), user),
        'salt://{0}/{1}-{2}-{3}'.format(__sls__, dotfile, grains('os'), user),
        'salt://{0}/{1}-{2}'.format(__sls__, dotfile, grains('fqdn')),
        'salt://{0}/{1}-{2}'.format(__sls__, dotfile, grains('os')),
        'salt://{0}/{1}-{2}'.format(__sls__, dotfile, user),
        'salt://{0}/{1}'.format(__sls__, dotfile),
      ]
    )
  File.recurse('{0}/.config/functions'.format(salt.user.info(user)['home']),
    user      = user,
    group     = salt.user.info(user)['gid'],
    file_mode = 600,
    dir_mode  = 700,
    recurse   = True,
    clean     = True,
    source    = [
      'salt://{0}/{1}-{2}-{3}'.format(__sls__, 'functions', grains('fqdn'), user),
      'salt://{0}/{1}-{2}-{3}'.format(__sls__, 'functions', grains('os'), user),
      'salt://{0}/{1}-{2}'.format(__sls__, 'functions', grains('fqdn')),
      'salt://{0}/{1}-{2}'.format(__sls__, 'functions', grains('os')),
      'salt://{0}/{1}-{2}'.format(__sls__, 'functions', user),
      'salt://{0}/{1}'.format(__sls__, 'functions'),
    ]
  )
