base_packages:
  pkg.installed:
    - pkgs: {{ pillar['base_packages'] }}
