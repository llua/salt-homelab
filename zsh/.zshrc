[[ $COLORTERM = rxvt-* ]] && print -Pn "\e]0;urxvt ${TTY#/dev/}\a"

# load wanted modules
for mod in 'pcre' 'net/tcp' 'complist'; do
  [[ -e $module_path[1]/zsh/$mod.so ]] && zmodload zsh/$mod
done
unset mod

# options
# Globbing
setopt   ExtendedGlob
# Misc
setopt   RcQuotes RecExact LongListJobs TransientRprompt MenuComplete MagicEqualSubst InteractiveComments CompleteInWord PromptSubst
# History
setopt   ExtendedHistory IncAppendHistory${${${+options[incappendhistorytime]}/1/Time}/0} HistIgnoreDups
# pushd settings
setopt   AutoPushd PushdMinus AutoCd PushdToHome PushdSilent PushdIgnoreDups
# Stuff we don't want
unsetopt BgNice AutoParamSlash Hup Correct CorrectAll Beep

HISTFILE=~/.zsh_history
[[ -f ~/.config/.zsh_history ]] && HISTFILE=~/.config/.zsh_history
HISTSIZE=15000
SAVEHIST=15000
MAILCHECK=1
mailpath+=( /var/spool/mail/${USER}(/N) ~/MailDir(/N) )
[[ $ZSH_VERSION == *-dev* ]] && manpath=( ~/.local/share/man(/N) )
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'
READNULLCMD=less
TIMEFMT=$(
  print -rP '%B %%J %b%K{12}%F{240} %%U %K{240}%F{12} user'\
    '%K{12}%F{240} %%S %K{240}%F{12} system'\
    '%K{12}%F{240} %%P %K{240}%F{12} cpu'\
    '%K{12}%F{240} %%*E %K{240}%F{12} total %f%k'
)
REPORTTIME=60
WATCHFMT=$(
  print -rP '%K{12}%F{8} %%n %K{240}%F{12} has %%a %%l @ %%D{%%T} %%D %f%k'
)

# autoload wrapper functions
fpath=( ~/.config/functions/wrappers $fpath )
autoload -Uz ~/.config/functions/wrappers/*(N:t)
# colourssssssssssssssssssssssssssssssssssssss
autoload -Uz colors && colors
ZLS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;01:cd=01;30:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
LS_COLORS=$ZLS_COLORS

# run-help's HELPDIR
HELPDIR=~/.cache/zsh-help

if [[ $OSTYPE = freebsd* ]]; then
  hash python=${${(v)commands[(I)python<->.<->]}[-1]}
fi
# hashed directories
hash -d dotfiles=$HOME/src/dotfiles/
hash -d zsh=$HOME/src/zsh/
hash -d build=$HOME/build/
hash -d tmp=$HOME/.local/tmp/
hash -d torrents=/usr/jail/rtorrent/usr/home/llua/torrents
zsh_directory_name() {
  zsh_directory_name_functions_comp "$@"
  zsh_directory_name_functions_jail "$@"
}

zsh_directory_name_functions_comp() {
  [[ $1 = c ]] || return 1
  [[ -prefix *: ]] && return 1
  local expl
  _values -s ':' 'dynamic directory prefixes' jail_${^$(jls name)}
}

zsh_directory_name_functions_jail() {
  emulate -L zsh
  setopt extendedglob

  local -a match mbegin mend

  case $1 in
    n)
      [[ $2 != (#b)jail_([^:]##):(?*) ]] && return 1
      typeset -ga reply
      reply=( $(jls -j ${match[1]} path)${match[2]} )
      ;;
    c)
      if [[ $PREFIX = (#b)jail_([^:]##):(?*) ]]; then
        compset -P 1 "jail_${(q)match[1]}:/"
        _path_files -S \] -r "^(\]| |\t|\n|\-)" -J "$match[1]-dynamic-directory" -W $(jls -j $match[1] path) -X "$match[1] dynamic-directory (press / to replace the ] suffix)"
      fi
      ;;
  esac
}

_dynamic_directory_name() {
  local func
  integer ret=1

  if [[ -n $functions[zsh_directory_name] ||
    ${+zsh_directory_name_functions} -ne 0 ]]; then
    [[ -n $functions[zsh_directory_name] ]] && zsh_directory_name c && ret=0
    for func in $zsh_directory_name_functions; do
      $func c && ret=0
    done
    return ret
  else
    _message 'dynamic directory name: implemented as zsh_directory_name c'
  fi
}

format_style() {
  if (( ${term_colors:=$(tput colors)} == 8 )); then
    print -r -- "$@"
  else
    print -r -- "%K{12}%B%F{240} $1 %K{240}%F{12} $argv[2,-1] %f%k"
  fi
}
# zshmodules(1)
# zstyle ':completion:function:completer:command:arguments:tag'

zstyle ':prompt:arx:'               users             llua ecook arx root
zstyle ':prompt:arx:'               primary-color     24 #  39 199
zstyle ':prompt:arx:'               secondary-color   45 # 105 210
zstyle ':prompt:arx:'               delimiter-color   219
zstyle ':prompt:arx:'               primary-color-8colors \
                                                      6
zstyle ':prompt:arx:'               secondary-color-8colors \
                                                      6
zstyle ':prompt:arx:'               delimiter-color-8colors \
                                                      5
zstyle ':prompt:arx:vcs_info:'      hosts             {netslum,sakubo,megin-fi,corbenik,folset}{,.mac-anu.org}
# separate man page completion by section.
zstyle -e ':completion:*:manuals.*' insert-sections   'if [[ $OSTYPE = solaris* ]]; then reply=(false); else reply=(true); fi'
zstyle ':completion:*:manuals'      separate-sections true 
# per-match descriptions (if available)
zstyle ':completion:*'              verbose           true
# descriptions of commands (if available)
zstyle ':completion:*'              extra-verbose     true
# default seperator between option -- description, update list-colors if changed.
zstyle ':completion:*'              list-separator    '::'
zstyle ':completion:*'              completer         _expand _complete _correct _approximate
# message telling you what you are completing
zstyle ':completion:*'              format            "$(format_style Completing: %d)"
zstyle ':completion:*'              select-prompt     "$(format_style Menu-selection: current selection at %p)"
# this style is used by `_arguments --'
zstyle ':completion:*'              auto-description  "$(format_style Completing: %d)"
# group completions by type
zstyle ':completion:*'              group-name        ''
# if there are atleast 0 matches, use menu selection
zstyle ':completion:*'              menu              select
# COLOUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUURSSSSSSSSSSSS
zstyle ':completion:*:default'      list-colors       'ma=01;07;35' 'tc=01;36' "${(s.:.)ZLS_COLORS}"
zstyle ':completion:*'              list-colors       '=(#s)(#b)[[:space:]]#*[[:space:]]#[[:space:]]#(::)[[:space:]]#(*)(#B)(#e)=0=38;5;219=38;5;24'
zstyle ':completion::complete:vim:option-u-1:*' \
                                    fake              NONE
zstyle ':completion:*:(scp|ssh|rsync|sftp|qemu-system-*):*' \
                                    tag-order         'users:-normal:local\ user users hosts:-normal:hashed\ host hosts'
# username completion
zstyle ':completion:*:users'        ignored-patterns  '*'
zstyle ':completion:*:users'        fake-always       ${(A)reply::={llua,arx,root}}
zstyle ':completion:*:users-normal' ignored-patterns  $reply
# hostname completion
zstyle ':completion:*:hosts'        ignored-patterns  '*'
zstyle ':completion:*:hosts'        fake-always       ${(A)reply::={umbra,ansuz,corbenik,netslum,nypumi,caerleon-medb,al-fadel,sakubo,tarvos,aurora,fidchell,login1,login2}}
zstyle ':completion:*:hosts-normal' ignored-patterns  $reply
# completion of pids
zstyle ':completion:*:processes'    format            "$(format_style Completing: %d "(pid user lstart %%%cpu %%%mem rss args)")"
zstyle ':completion:*:processes'    command           'ps -o pid,user,lstart,pcpu,pmem,rss,args -A'
zstyle ':completion:*:nsenter:*:processes' \
                                    format            "$(format_style Completing: %d "(pid command systemd-machined-id utsns netns mntns pidns ipcns userns)")"
zstyle ':completion:*:nsenter:*:processes' \
                                    command           'ps -o pid,comm,machine,utsns,netns,mntns,pidns,ipcns,userns -A'
# completion of process names 
zstyle ':completion:*:killall:*'    command           'ps -o comm -A'
# grouping stuff menu selection mostly
zstyle ':completion::complete:-subscript-::' \
                                    tag-order         'indexes association-keys'
zstyle ':completion:*:*:configure:*' \
                                    tag-order         'options:-enable:enable\ feature options:-other options:-disable:disable\ feature'
zstyle ':completion:*:configure:*:options-enable' \
                                    ignored-patterns  '^--enable-*'
zstyle ':completion:*:configure:*:options-other' \
                                    ignored-patterns  '--(dis|en)able-*'
zstyle ':completion:*:configure:*:options-disable' \
                                    ignored-patterns  '^--disable-*'
zstyle ':completion::complete:pacman:argument-rest:' \
                                    group-order       repo_packages packages
zstyle -e ':completion:*:*:systemctl-(((re|)en|dis)able|status|(*re|)start|reload*):*' \
                                    tag-order         'local type; for type in service template target timer socket mount slice device busname
                                                         reply+=( systemd-units:-${type}:${type} )
                                                         reply=( "$reply systemd-units:-misc:misc" )'
zstyle ':completion:*:systemd-units-service' \
                                    ignored-patterns  '^*.service'
zstyle ':completion:*:systemd-units-template' \
                                    ignored-patterns  '^*@'
zstyle ':completion:*:systemd-units-target' \
                                    ignored-patterns  '^*.target'
zstyle ':completion:*:systemd-units-timer' \
                                    ignored-patterns  '^*.timer'
zstyle ':completion:*:systemd-units-socket' \
                                    ignored-patterns  '^*.socket'
zstyle ':completion:*:systemd-units-mount' \
                                    ignored-patterns  '^*.mount'
zstyle ':completion:*:systemd-units-slice' \
                                    ignored-patterns  '^*.slice'
zstyle ':completion:*:systemd-units-device' \
                                    ignored-patterns  '^*.device'
zstyle ':completion:*:systemd-units-busname' \
                                    ignored-patterns  '^*.busname'
zstyle ':completion:*:systemd-units-misc' \
                                    ignored-patterns  '*(@|.(service|target|timer|socket|mount|slice|device|busname))'
zstyle ':completion:*:*:machinectl*:*' \
                                    tag-order         'systemd-machines:-qemu:qemu\ virtual\ machine systemd-machines:-container:container systemd-machines:-misc:machine'
zstyle ':completion:*:systemd-machines-misc' \
                                    ignored-patterns  '(lxc|qemu)-*'
zstyle ':completion:*:systemd-machines-container' \
                                    ignored-patterns  '^lxc-*'
zstyle ':completion:*:systemd-machines-qemu' \
                                    ignored-patterns  '^qemu-*'
# misc stuff
zstyle ':completion:*'              special-dirs      ..
zstyle :completion::complete:-command-::commands \
                                    ignored-patterns  restart reboot
zstyle :completion::complete:-tilde-:: \
                                    group-order       named-directories users
zstyle ':completion:*:*:(lua|lua5[12]|lua-#5.[12]):*:*' \
                                    file-patterns     '*(-/):directories:directories *.(#i)lua(-.):globbed-files:lua\ scripts ^*.(#i)lua(-.):other-files:other\ files'
# avoiding _perl's restrictive _files glob
zstyle ':completion:*:*:perl:*:*'   file-patterns     '*(-/):directories:directories *.(p[ml]|PL|t)(-.):globbed-files:perl\ scripts *~*.(p[ml]|PL|t)(^/):other-files:other\ files'
zstyle ':completion::complete:perl:option-M-1:' \
                                    use-cache         true
zstyle ':completion::complete:salt(|-cp|-call):minions:' \
                                    cache-ttl         60 days
zstyle ':completion::complete:journalctl:option-b-1:' \
                                    sort              false
zstyle ':completion::complete:reautoload:argument-rest:' \
                                    tag-order         'functions:-nounderscore functions:-underscore'
zstyle ':completion:*:functions-nounderscore'         ignored-patterns '_*'
zstyle ':completion:*:functions-underscore'           ignored-patterns '^_*'
# complete jails from /usr/jail when -c is used
zstyle -e ':completion::complete:jail:argument-rest:jails' \
                                                      fake '[[ -v opt_args[(i)-c] ]] && reply=(/usr/jail/^freebsd*(:t))'
zstyle ':completion:*'              cache-path        ${ZDOTDIR:-$HOME/.config}/zcompcache
zstyle ':completion:*:(mpc|zypper|sysrc|ansible(|-doc)|salt(|-cp|-call|-run|-key)):*' \
                                    use-cache         true
zstyle ':completion:most-recent-file:*' \
                                    match-original    both
zstyle ':completion:most-recent-file:*' \
                                    file-sort         modification
zstyle ':completion:most-recent-file:*' \
                                    file-patterns     '*:all\ files'
zstyle ':completion:most-recent-file:*' \
                                    hidden            all
zstyle ':completion:most-recent-file:*' \
                                    completer         _files
zstyle ':completion:*:events'       range             50
zstyle ':completion:*'              insert-tab        false
zstyle ':completion:*'              list-dirs-first   true # may cause completers to fail, look into why.
zstyle ':completion:*'              accept-exact      false
zstyle ':completion:*'              matcher-list      '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=* l:|=*'
zstyle ':completion:*'              use-compctl       false
zstyle ':completion:*'              rehash            true
autoload -Uz compinit
compinit

# Prompt stuff
autoload -Uz promptinit; promptinit
prompt arx >/dev/null 2>&1

zle -C most-recent-file menu-complete _generic
if [[ $OSTYPE == *linux* ]]; then
  if [[ -f /etc/arch-release ]]; then
    AUTOREMOVE() sudo pacman -R ${(of)"$(pacman -Qdtq)"}
    AUTOCLEAN() sudo pacman -Sc
  fi
fi

unalias -m '*'
if ! [[ $OSTYPE == (openbsd|solaris)* ]]; then
  alias cp='cp -i'
  alias mv='mv -i'
  alias rm='rm -v'
  alias du='du -h'
  alias df='df -h'
fi

# help
unalias  run-help 2>/dev/null
autoload -Uz run-help

# stalk other users on the system
watch=(notme)

# keybinds
autoload -Uz select-word-style; select-word-style shell
bindkey -v
bindkey -M viins -r '\e/'
bindkey -M vicmd 'd-d'                  kill-line
bindkey -M vicmd 'D'                    vi-kill-eol
bindkey -M viins '^W'                   backward-kill-word
bindkey -M vicmd 'K'                    run-help
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e.'                  insert-last-word
bindkey -M viins '\e^M'                 self-insert-unmeta
bindkey -M viins '^Xm'                  _most_recent_file
bindkey -M viins "^N"                   most-recent-file
bindkey -M viins '^Xh'                  _complete_help
bindkey -M viins '^X?'                  _complete_debug
bindkey -M viins '^P'                   push-line-or-edit
bindkey -M viins '\ee'                  expand-word
bindkey -M viins '^?'                   backward-delete-char
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e[d'                 vi-backward-word
bindkey -M vicmd '\e[d'                 vi-backward-word
bindkey -M viins '\e[1;5D'              vi-backward-word
bindkey -M vicmd '\e[1;5D'              vi-backward-word
bindkey -M viins '\e[c'                 vi-forward-word
bindkey -M vicmd '\e[c'                 vi-forward-word
bindkey -M viins '\e[1;5C'              vi-forward-word
bindkey -M vicmd '\e[1;5C'              vi-forward-word
vi-exit() { print -sr -- $BUFFER; builtin exit; }; zle -N vi-exit; bindkey -M vicmd 'ZZ' vi-exit
bindkey -M menuselect '^[[Z'            reverse-menu-complete
bindkey -M menuselect '^r'              history-incremental-search-backward
bindkey -M menuselect '\e^M'            accept-and-menu-complete
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
zle -N edit-command-line
bindkey -M viins '^E'                   edit-command-line
bindkey -M vicmd 'v'                    edit-command-line
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
  Enter             "${terminfo[kent]}"
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

bind2maps emacs viins vicmd -- Enter            accept-line
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
bind2maps emacs             -- Right            forward-char
bind2maps emacs             -- urxvt-Right      forward-char
bind2maps       viins       -- BackSpace        backward-delete-char
bind2maps       viins       -- urxvt-BackSpace  backward-delete-char
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle-line-init() {
        emulate -L zsh
        printf '%s' ${terminfo[smkx]}
    }
    zle-line-finish() {
        emulate -L zsh
        printf '%s' ${terminfo[rmkx]}
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

stty start '' stop '' erase '^?'
unfunction bind2maps format_style; unset key reply term_colors

if autoload +X -z localrc 2>/dev/null; then
  localrc
fi
