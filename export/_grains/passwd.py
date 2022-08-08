def passwd():
  from pwd import getpwall

  return {
    'passwd': {
      user.pw_name: {
        attr[3:]: getattr(user, attr)
        for attr in [
          'pw_passwd', 'pw_uid', 'pw_gid',
          'pw_gecos', 'pw_dir', 'pw_shell'
        ]
      }
      for user in getpwall()
    }
  }
