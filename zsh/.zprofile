setopt globassign extendedglob

path=( /sbin /usr/sbin  "$path[@]" ~/(|.local/)#bin(/N) )
typeset -U path 
export EDITOR='vim' PAGER='less' PATH

unsetopt globassign extendedglob
