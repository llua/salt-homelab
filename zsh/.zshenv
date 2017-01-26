# this file is sourced in by zsh process, make it count.
fpath=( ~/.config/functions(-local|)(On/N) /usr/share/zsh/site-functions(/N) $^fpath[@](N) )

# autoload my functions in .config/functions/ and zmv
autoload -Uz ${ZDOTDIR:-$HOME/.config}/functions(|-local)/**/[^_+]*(N^/:t) zmv edit-command-line 2>/dev/null
