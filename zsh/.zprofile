setopt globassign extendedglob

path=( /sbin /usr/sbin  "$path[@]" ~/(|.local/)#bin(/N) )
typeset -U path 
export EDITOR='vim' PAGER='less' PATH LESS='-XR'
[[ -f /etc/SuSE-release ]] && export GROFF_NO_SGR=1

unsetopt globassign extendedglob
