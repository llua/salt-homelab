{% for user in ['root', 'llua', 'ecook', 'nexecook'] %}
  {% if user in salt['user.list_users']() %}
    {{ salt['user.info'](user).home }}/.vimrc:
      file.managed:
        - user: {{ user }}
        - group: {{ salt['user.info'](user).gid }}
        - mode: 600
        - source:
          - salt://{{ sls }}/.vimrc-{{ grains['fqdn'] }}-{{ user }}
          - salt://{{ sls }}/.vimrc-{{ grains['os'] }}-{{ user }}
          - salt://{{ sls }}/.vimrc-{{ grains['fqdn'] }}
          - salt://{{ sls }}/.vimrc-{{ grains['os'] }}
          - salt://{{ sls }}/.vimrc-{{ user }}
          - salt://{{ sls }}/.vimrc
          #- require:
          #- - sls: users
    {{ salt['user.info'](user).home }}/.vim:
      file.recurse:
        - user: {{ user }}
        - group: {{ salt['user.info'](user).gid }}
        - file.recurse: 600
        - dir_mode: 700
        - recurse: true
        - clean: true
        - source:
          - salt://{{ sls }}/.vim-{{ grains['fqdn'] }}-{{ user }}
          - salt://{{ sls }}/.vim-{{ grains['os'] }}-{{ user }}
          - salt://{{ sls }}/.vim-{{ grains['fqdn'] }}
          - salt://{{ sls }}/.vim-{{ grains['os'] }}
          - salt://{{ sls }}/.vim-{{ user }}
          - salt://{{ sls }}/.vim
          #- require:
          #- - sls: users
  {% endif  %}
{% endfor %}
