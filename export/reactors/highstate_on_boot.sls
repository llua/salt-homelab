setup minion config:
  local.state.apply:
    - tgt: {{ data['id'] }}
    - args:
      - salt.minion

highstate_run:
  local.state.apply:
    - tgt: {{ data['id'] }}
