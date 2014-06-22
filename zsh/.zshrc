# load wanted modules
for mod in 'pcre' 'net/tcp' 'complist'; do
  [[ -e $module_path[1]/zsh/$mod.so ]] && zmodload zsh/$mod
done
unset mod

# options
# Globbing
setopt   ExtendedGlob GlobAssign
# Misc
setopt   RcQuotes RecExact LongListJobs TransientRprompt MagicEqualSubst AutoMenu CompleteInWord
# History 
setopt   ExtendedHistory HistIgnoreAllDups AppendHistory HistNoStore IncAppendHistory ShareHistory
# pushd settings
setopt   AutoPushd PushdMinus AutoCd PushdToHome PushdSilent PushdIgnoreDups
# Stuff we don't want
unsetopt BgNice AutoParamSlash Hup Correct CorrectAll MenuComplete AutoList Beep

# Set fpath
fpath=( ~/.config/functions(/N) $^fpath[@](N) )

# History & mail stuff
HISTFILE=~/(.config/)#.zsh_history(N[1])
HISTSIZE=15000
SAVEHIST=15000
MAILCHECK=1
mailpath+=( /var/spool/mail/${USER}(/N) ~/MailDir(/N) )
[[ $ZSH_VERSION == *(-)#dev* ]] && manpath=( ~/.local/share/man(/N) )

READNULLCMD=less

# colourssssssssssssssssssssssssssssssssssssss
autoload -Uz colors && colors
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;01:cd=40;01;36:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

# Prompt stuff
if (( $#parameters[(I)SSH_(CLIENT|TTY|CONNECTION)] )); then
  PROMPT="%F{6}%m%f%# "
else
  PROMPT='%% '
fi
RPROMPT="%B%F{6}%~%f%b"

# run-help's HELPDIR
HELPDIR=~/.cache/zsh-help(N)

# autoload my functions in .config/functions/ and zmv
autoload -Uz ${ZDOTDIR:-$HOME/.config}/functions/**/[^_]*(N.:t) zmv edit-command-line 2>/dev/null

# Completion settings zshmodules(1)
# zstyle ':completion:function:completer:command:arguments:tag'

# separate man page completion by section.
zstyle ':completion:*:manuals.*'                insert-sections   true
zstyle ':completion:*:manuals'                  separate-sections true 
# per-match descriptions (if available)
zstyle ':completion:*'                          verbose           true
# descriptions of commands (if available)
zstyle ':completion:*'                          extra-verbose     true
# if a description isn't defined, use the option's description (from -h|--help)
zstyle ':completion:*'                          auto-description  'specify: %d'
# default seperator between option -- description
zstyle ':completion:*'                          list-separator    '::'
zstyle ':completion:*'                          completer         _expand _complete _correct _approximate
# message telling you what you are completing
zstyle ':completion:*'                          format            'Completing %d'
# group completions by type
zstyle ':completion:*'                          group-name        ''
# if there are atleast 0 matches, use menu selection
zstyle ':completion:*'                          menu              select=0
# COLOUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUURSSSSSSSSSSSS
zstyle ':completion:*:default'                  list-colors       "${(s.:.)LS_COLORS}"
zstyle ':completion:*'                          list-colors       ''
# username completion
zstyle ':completion:*:(scp|ssh|rsync|telnet|qemu-system-*):*' users             llua arx root
# hostname completion
zstyle ':completion:*:(scp|ssh|rsync|telnet|qemu-system-*):*' hosts             umbra corbenik netslum login1 login2
# completion of pids owned by $USER
zstyle ':completion:*:(kill|strace|pidstat):*'  command           'ps -u $USER -o pid,cmd,tty'
# completion of process names 
zstyle ':completion:*:killall:*'                command           'ps -u $USER -o comm'
zstyle ':completion:*'                          insert-tab        false
zstyle ':completion:*'                          list-dirs-first   true
zstyle ':completion:*'                          accept-exact      false
zstyle ':completion:*'                          matcher-list      '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=* l:|=*'
zstyle ':completion:*'                          select-prompt     %SScrolling active: current selection at %p%s
zstyle ':completion:*'                          use-compctl       false
autoload -Uz compinit
compinit

# generate completions from gnu tool's --help
if [[ $OSTYPE == linux-gnu ]]; then
  for cmd in sed comm ss netstat tail head {z,e,f,}grep date vmstat auditctl virt-{install,clone,convert,xml} \
    lxc-{start,stop,create,clone,autostart,cgroup,checkconfig,console,destroy,device,execute,freeze,info,ls} \
    lxc-{monitor,snapshot,start-ephemeral,top,unfreeze,unshare,attach,top,usernsexec,wait}
  do
    compdef _gnu_generic $cmd
  done
  unset cmd
fi

# help
unalias  run-help 2>/dev/null
autoload run-help

# stalk other users on the system
watch=(notme)

# keybinds
bindkey -v
bindkey -M vicmd 'd-d'                  kill-line
bindkey -M vicmd 'D'                    vi-kill-eol
bindkey -M vicmd 'K'                    run-help
bindkey -M viins -r '\e/'
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e.'                  insert-last-word
bindkey -M viins '^Xm'                  _most_recent_file
bindkey -M viins '^X?'                  _complete_help
bindkey -M viins '^Xh'                  _complete_debug
bindkey -M viins '^?'                   backward-delete-char
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e[d'                 vi-backward-word
bindkey -M vicmd '\e[d'                 vi-backward-word
bindkey -M viins '\e[c'                 vi-forward-word
bindkey -M vicmd '\e[c'                 vi-forward-word
vi-exit() { print -s -- $BUFFER; builtin exit; }; zle -N vi-exit; bindkey -M vicmd 'ZZ' vi-exit
bindkey -M menuselect '^[[Z'            reverse-menu-complete
if (( $+terminfo[kLFT] )); then 
  bindkey -M viins "${terminfo[kLFT]}"  vi-backward-word
  bindkey -M vicmd "${terminfo[kLFT]}"  vi-backward-word
fi
if (( $+terminfo[kLFT] )); then
  bindkey -M viins "${terminfo[kRIT]}"  vi-forward-word
  bindkey -M vicmd "${terminfo[kRIT]}"  vi-forward-word
fi
bindkey -M emacs '^[ '                  magic-space
bindkey -M emacs '^[!'                  expand-history
bindkey '^Z' undo
zle -N edit-command-line; bindkey '^E' edit-command-line
# ft's function
typeset -A key
key=(
  Home              "${terminfo[khome]}"
  End               "${terminfo[kend]}"
  Insert            "${terminfo[kich1]}"
  Delete            "${terminfo[kdch1]}"
  Up                "${terminfo[kcuu1]}"
  Down              "${terminfo[kcud1]}"
  Left              "${terminfo[kcub1]}"
  Right             "${terminfo[kcuf1]}"
  PageUp            "${terminfo[kpp]}"
  PageDown          "${terminfo[knp]}" 
  BackSpace         "${terminfo[kbs]}"
  urxvt-Home        '\e[7~'
  urxvt-End         '\e[8~'
  urxvt-Insert      '\e[2~'
  urxvt-Delete      '\e[3~'
  urxvt-Up          '\e[A'
  urxvt-Down        '\e[B'
  urxvt-Left        '\e[D'
  urxvt-Right       '\e[C'
  urxvt-PageUp      '\e[5~'
  urxvt-PageDown    '\e[6~'
  urxvt-BackSpace   '^H'
)

function bind2maps () {
  local i sequence widget
  local -a maps

  while [[ "$1" != "--" ]]; do
    maps+=( "$1" )
    shift
  done
  shift

  sequence="${key[$1]}"
  widget="$2"

  [[ -z "$sequence" ]] && return 1

  for i in "${maps[@]}"; do
    bindkey -M "$i" "$sequence" "$widget"
  done
}

bind2maps emacs             -- Home             beginning-of-line
bind2maps emacs             -- urxvt-Home       beginning-of-line
bind2maps       viins vicmd -- Home             vi-beginning-of-line
bind2maps       viins vicmd -- urxvt-Home       vi-beginning-of-line
bind2maps emacs             -- End              end-of-line
bind2maps emacs             -- urxvt-End        end-of-line
bind2maps       viins vicmd -- End              vi-end-of-line
bind2maps       viins vicmd -- urxvt-End        vi-end-of-line
bind2maps emacs viins       -- Insert           overwrite-mode
bind2maps emacs viins       -- urxvt-Insert     overwrite-mode
bind2maps             vicmd -- Insert           vi-insert
bind2maps             vicmd -- urxvt-Insert     vi-insert
bind2maps emacs             -- Delete           delete-char
bind2maps emacs             -- urxvt-Delete     delete-char
bind2maps       viins vicmd -- Delete           vi-delete-char
bind2maps       viins vicmd -- urxvt-Delete     vi-delete-char
bind2maps emacs viins vicmd -- Up               up-line-or-search
bind2maps emacs viins vicmd -- urxvt-Up         up-line-or-search
bind2maps emacs viins vicmd -- Down             down-line-or-search
bind2maps emacs viins vicmd -- urxvt-Down       down-line-or-search
bind2maps emacs             -- Left             backward-char
bind2maps emacs             -- urxvt-Left       backward-char
bind2maps       viins vicmd -- Left             vi-backward-char
bind2maps       viins vicmd -- urxvt-Left       vi-backward-char
bind2maps emacs             -- Right            forward-char
bind2maps emacs             -- urxvt-Right      forward-char
bind2maps       viins vicmd -- Right            vi-forward-char
bind2maps       viins vicmd -- urxvt-Right      vi-forward-char
bind2maps       viins       -- BackSpace        backward-delete-char
bind2maps       viins       -- urxvt-BackSpace  backward-delete-char

unfunction bind2maps; unset key 
unsetopt globassign
