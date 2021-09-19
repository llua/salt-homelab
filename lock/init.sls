lock:
  cmd.run:
    - name: xscreensaver-command -lock
    - runas: llua
    - bg: True
    - env:
        - DISPLAY: ":0"
    - unless: 'sudo -u llua xscreensaver-command -time 2>&1 | grep -i locked'
