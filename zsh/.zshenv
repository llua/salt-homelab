# this file is sourced in by every zsh process, make it count.
fpath=( ~/.config/functions(-local|)(On/N) /usr/share/zsh/site-functions(/N) $^fpath[@](N) )
typeset -U fpath

# autoload my functions in .config/functions/ and zmv
if [[ -o interactive ]] || (( $+ZSH_EXECUTION_STRING )); then
  autoload -Uz ${(M)^fpath:#*$USER*/functions(|-local)}/[^_+]*(N^/:t) zmv edit-command-line 2>/dev/null
fi

case $VENDOR in
  (ubuntu)          [[ -o interactive ]] && skip_global_compinit=1;|
  ((debian|ubuntu)) [[ -o interactive ]] && DEBIAN_PREVENT_KEYBOARD_CHANGES=1;|
esac
