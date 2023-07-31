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
      if [[ -f /etc/SUSE-brand ]]; then
        path=( /sbin /usr/sbin "$path[@]" )
        unsetopt globalrcs
      fi
      if test -r /etc/os-release && grep -qF platform:el7 $_; then
        export LESS_TERMCAP_mb=${(%):-%k%F{60}}
        export LESS_TERMCAP_md=${(%):-%B}
        export LESS_TERMCAP_me=${(%):-%f%k%b%s%u}
        export LESS_TERMCAP_se=${(%):-%k%f}
        export LESS_TERMCAP_so=${(%):-%K{60}%F{225}}
        export LESS_TERMCAP_ue=${(%):-%k%f}
        export LESS_TERMCAP_us=${(%):-%k%F{141}}
        export GROFF_NO_SGR=1
      else
        export MANPAGER='less -R --use-color -Dd+60 -Du141 -DP225.60'
      fi
    ;;
    solaris*)
      path=(/sbin /usr/sbin $path)
    ;;
  esac
  path+=( ~/(|.local/)#bin(/N) )
}

