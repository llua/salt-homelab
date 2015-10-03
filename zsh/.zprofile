() {
  setopt localoptions extendedglob

  typeset -gU path
  # the -g is needed to prevent the tied parameter from becoming empty
  export EDITOR='vim' PAGER='less' PATH LESS='-XRSF'

  case $OSTYPE in 
    (freebsd|solaris)*)
      export MANWIDTH=tty
    ;|
    openbsd*)
      export "PKG_PATH=http://mirror.team-cymru.org/pub/OpenBSD/$(uname -r)/packages/$(uname -p)"
    ;;
    *linux*)
      if [[ -f /etc/SuSE-release ]]; then
        path=( /sbin /usr/sbin "$path[@]" ~/(|.local/)#bin(/N) )
        unsetopt globalrcs
        export GROFF_NO_SGR=1
      else
        path+=( ~/(|.local/)#bin(/N) )
      fi
    ;;
    solaris*)
      path=(/sbin /usr/sbin $path)
    ;;
  esac
}

