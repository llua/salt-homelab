autoload -U colors && colors
#############
#Environment#
#############

EDITOR="vim"
typeset -U path mailpath
path+=(~/{,.local/}bin(/N) "$path[@]")
CDPATH=:~/.local
mailpath+=( /var/spool/mail/${USER}(/N) ~/MailDir(/N) )
GREP_OPTIONS='--color=auto'
PAGER='less'

for x in EDITOR CDPATH mailpath GREP_OPTIONS PAGER
do
  export $x
done
