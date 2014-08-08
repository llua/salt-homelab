setopt globassign extendedglob

path=( /sbin /usr/sbin  "$path[@]" ~/(|.local/)#bin(/N) )
typeset -U path 
export EDITOR='vim' PAGER='less' PATH LESS='-XR'

unsetopt globassign extendedglob
