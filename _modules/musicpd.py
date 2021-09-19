# requires salt-minion to use python >= 3.7
try:
    from mpd import MPDClient
    HAS_MPD = True
except ImportError:
    HAS_MPD = False

__virtualname__ = 'musicpd'

def __virtual__():
    if HAS_MPD:
        return True
    else:
        return False, 'python-mpd2 is not found, it is installed?'

if HAS_MPD:
    # when attributes that does not exist is called, this method handles it.
    # also meaning a normal function definition has precedence if special handling is needed
    def __getattr__(attr):
        if attr in __dir__():
            # salt checks that __getattr__ returns is a function, a class method won't work
            def func(*args, **kwargs):
                # deletes keywords salt injects since MPDClient doesn't handle them
                for k in [k for k in kwargs if k.startswith('__')]:
                    del kwargs[k]
                if args or kwargs:
                    return getattr(MPD(), attr)(*args, **kwargs)
                else:
                    return getattr(MPD(), attr)()
            return func
        else:
            raise AttributeError

    def __dir__():
        return dir(MPD())

config = {
    'server': 'localhost',
    'port': 6600,
}

def __init__(opts):
    config.update(opts.get(__virtualname__, {}))

class MPD():
    def __init__(self):
        self._client = MPDClient()
        self._client.connect(config['server'], config['port'])
        if 'password' in config:
            self._client.password(config['password'])

    def __getattr__(self, attr):
        if not attr.startswith('_'):
            return getattr(self._client, attr)

    def __dir__(self):
        return dir(self._client)
