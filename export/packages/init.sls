base_packages:
  pkg.installed:
    - pkgs: {{ pillar['packages'] }}
