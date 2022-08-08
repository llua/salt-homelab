() {
  setopt localoptions extendedglob

  typeset -gU path
  # the -g is needed to prevent the tied parameter from becoming empty
  export EDITOR='vim' PAGER='less' PATH LESS='-XRSF'
  if (( UID != 0 )) && {
     export SSH_AUTH_SOCK=~/.ssh/agent.socket
     ssh-add -L
     (( $? == 2 ))
   }; then
         rm -f "$SSH_AUTH_SOCK"
         ssh-agent -a "$SSH_AUTH_SOCK"
  fi > /dev/null 2>&1

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
      if [[ -f /etc/SUSE-brand ]] || [[ -f /etc/redhat-release ]]; then
        export GROFF_NO_SGR=1
      fi
      if [[ -f /etc/SUSE-brand ]]; then
        path=( /sbin /usr/sbin "$path[@]" ~/(|.local/)#bin(/N) )
        unsetopt globalrcs
      fi
    ;;
    solaris*)
      path=(/sbin /usr/sbin $path)
    ;;
  esac
  path+=( ~/(|.local/)#bin(/N) )
}

