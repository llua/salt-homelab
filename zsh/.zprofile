#############
#Environment#
#############

EDITOR="vim"
path+=(~/{,.local/}bin(/N) "$path[@]")
typeset -U path mailpath
CDPATH=:~/.local
mailpath+=( /var/spool/mail/${USER}(/N) ~/MailDir(/N) )
PAGER='less'

for x in EDITOR CDPATH mailpath PAGER
do
  export $x
done
