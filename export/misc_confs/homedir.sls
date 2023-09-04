#!jinja | pyobjects
# vim: syn=python
"""
an (hopefully) easier way to manage less important stuff in my homedir
without creating specific state files for the program.
"""
def filelist_to_dict():
  """
  gathers a list of files in export/misc_confs/files/homedir*
  to manage within my home directory.

  homedir/ being the default, with the lowest precedence
  homedir-$user being specific to the user
  homedir-$os being specific to the os
  homedir-$os-$user being specific to the os and user
  homedir-$fqdn being specific to the fqdn
  homedir-$fqdn-$user being specific to the fqdn and user, with the highest precedence
  """
  file_list = __salt__['cp.list_master'](prefix="{0}/files/homedir".format(sls_root), saltenv="{{ saltenv }}")
  prefixes  = [
    '{0}/{1}/'.format(sls_root, 'files/homedir'),
    '{0}/{1}-{2}/'.format(sls_root, 'files/homedir', user),
    '{0}/{1}-{2}/'.format(sls_root, 'files/homedir', grains('os')),
    '{0}/{1}-{2}-{3}/'.format(sls_root, 'files/homedir', grains('os'), user),
    '{0}/{1}-{2}/'.format(sls_root, 'files/homedir', grains('fqdn')),
    '{0}/{1}-{2}-{3}/'.format(sls_root, 'files/homedir', grains('fqdn'), user),
  ]
  mapping   = {
    file.removeprefix(prefix): {}
      for prefix in prefixes
      for file in file_list
      if file.startswith(prefix)
  }
  return mapping

sls      = '{{ sls }}'
sls_root = sls.replace('.homedir','')
users    = (set(__pillar__.get('personal_dotfiles', []))
            .intersection(__salt__['user.list_users']())
            .difference(set(['root']))) # no need to manage stuff in /root

for user in users:
  home = __salt__['user.info'](user)['home']
  for name, _ in filelist_to_dict().items():
    file = f"{home}/{name}"
    File.managed("misc_confs - manage file: {0}".format(file),
      name     = file,
      user     = user,
      group    = __salt__['user.info'](user)['gid'],
      mode     = 600,
      dir_mode = 700,
      makedirs = True,
      template = 'jinja',
      #keep_symlinks = True,
      #force_symlinks = True,
      source   = [
        'salt://{0}/{1}-{2}-{3}/{4}'.format(sls_root, 'files/homedir', grains('fqdn'), user, name),
        'salt://{0}/{1}-{2}/{3}'.format(sls_root, 'files/homedir', grains('fqdn'), name),
        'salt://{0}/{1}-{2}-{3}/{4}'.format(sls_root, 'files/homedir', grains('os'), user, name),
        'salt://{0}/{1}-{2}/{3}'.format(sls_root, 'files/homedir', grains('os'), name),
        'salt://{0}/{1}-{2}/{3}'.format(sls_root, 'files/homedir', user, name),
        'salt://{0}/{1}/{2}'.format(sls_root, 'files/homedir', name),
      ]
    )
