() {
  setopt localoptions extendedglob

  path=( /sbin /usr/sbin "$path[@]" ~/(|.local/)#bin(/N) )
  typeset -U path 
  export EDITOR='vim' PAGER='less' PATH LESS='-XR'

  [[ -f /etc/SuSE-release ]] && export GROFF_NO_SGR=1
  case $OSTYPE in 
    (freebsd|solaris)*)
      export MANWIDTH=tty
    ;;
    openbsd*)
      export "PKG_PATH=http://mirror.team-cymru.org/pub/OpenBSD/$(uname -r)/packages/$(uname -p)"
    ;;
  esac
}
