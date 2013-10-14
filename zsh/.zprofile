setopt globassign extendedglob
path+=(~/(|.local/)#bin(/N) "$path[@]")
typeset -U path 
export EDITOR='vim' PAGER='less' PATH
