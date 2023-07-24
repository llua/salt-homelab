() {
  setopt localoptions extendedglob

  typeset -gU path
  # the -g is needed to prevent the tied parameter from becoming empty
  export EDITOR='vim' PAGER='less' PATH LESS='-XRSF' MANPAGER='less -R --use-color -Dd+60 -Du141 -DP225.60'
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
      if [[ -f /etc/SUSE-brand ]]; then
        path=( /sbin /usr/sbin "$path[@]" )
        unsetopt globalrcs
      fi
    ;;
    solaris*)
      path=(/sbin /usr/sbin $path)
    ;;
  esac
  path+=( ~/(|.local/)#bin(/N) )
  [[ $HOST = ran-hati* ]] && export TZ=America/Detroit
}

