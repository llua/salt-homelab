# this file is sourced in by zsh process, make it count.
fpath=( ~/.config/functions(-local|)(On/N) /usr/share/zsh/site-functions(/N) $^fpath[@](N) )
typeset -U fpath

# autoload my functions in .config/functions/ and zmv
autoload -Uz ${ZDOTDIR:-$HOME/.config}/functions(|-local)/**/[^_+]*(N^/:t) zmv edit-command-line 2>/dev/null

case $VENDOR in
  (ubuntu)          skip_global_compinit=1;|
  ((debian|ubuntu)) DEBIAN_PREVENT_KEYBOARD_CHANGES=1;|
esac
