highstate_run:
  local.state.apply:
    - tgt: {{ data['id'] }}
    - args:
      - saltenv: base
      - pillarenv: base
