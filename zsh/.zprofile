() {
  setopt localoptions extendedglob

  typeset -gU path
  # the -g is needed to prevent the tied parameter from becoming empty
  export EDITOR='vim' PAGER='less' PATH LESS='-XRSF'
  [[ -f ~/.ssh/agent.env ]] && . ~/.ssh/agent.env

  case $OSTYPE in
    *)
      (( $+commands[ruby] )) && path+=( "$(ruby -e 'print Gem::user_dir + "/bin"')" )
    ;|
    (freebsd|solaris)*)
      export MANWIDTH=tty
    ;|
    openbsd*)
      export "PKG_PATH=http://ftp4.usa.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(uname -p)"
    ;;
    *linux*)
      if [[ -f /etc/SuSE-release ]] || [[ -f /etc/redhat-release ]]; then
        export GROFF_NO_SGR=1
      fi
      if [[ -f /etc/SuSE-release ]]; then
        path=( /sbin /usr/sbin "$path[@]" ~/(|.local/)#bin(/N) )
        unsetopt globalrcs
      else
        path+=( ~/(|.local/)#bin(/N) )
      fi
    ;;
    solaris*)
      path=(/sbin /usr/sbin $path)
    ;;
  esac
}

