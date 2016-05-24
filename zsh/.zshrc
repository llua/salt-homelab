# load wanted modules
for mod in 'pcre' 'net/tcp' 'complist'; do
  [[ -e $module_path[1]/zsh/$mod.so ]] && zmodload zsh/$mod
done
unset mod

# options
# Globbing
setopt   ExtendedGlob
# Misc
setopt   RcQuotes RecExact LongListJobs TransientRprompt MagicEqualSubst InteractiveComments CompleteInWord PromptSubst
# History 
setopt   ExtendedHistory HistIgnoreAllDups HistNoStore IncAppendHistory Sharehistory
# pushd settings
setopt   AutoPushd PushdMinus AutoCd PushdToHome PushdSilent PushdIgnoreDups
# Stuff we don't want
unsetopt BgNice AutoParamSlash Hup Correct CorrectAll MenuComplete AutoList Beep

fpath=( ~/.config/functions(-local|)(On/N) /usr/share/zsh/site-functions(/N) $^fpath[@](N) )
HISTFILE=~/.zsh_history
[[ -f ~/.config/.zsh_history ]] && HISTFILE=~/.config/.zsh_history
HISTSIZE=15000
SAVEHIST=15000
MAILCHECK=1
mailpath+=( /var/spool/mail/${USER}(/N) ~/MailDir(/N) )
[[ $ZSH_VERSION == *-dev* ]] && manpath=( ~/.local/share/man(/N) )
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'
READNULLCMD=less

# colourssssssssssssssssssssssssssssssssssssss
autoload -Uz colors && colors
ZLS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;01:cd=01;30:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
LS_COLORS=$ZLS_COLORS

# run-help's HELPDIR
HELPDIR=~/.cache/zsh-help

# hashed directories
hash -d dotfiles=$HOME/src/dotfiles/
hash -d zsh=$HOME/src/zsh/
hash -d build=$HOME/build/
hash -d tmp=$HOME/.local/tmp/

# autoload my functions in .config/functions/ and zmv
autoload -Uz ${ZDOTDIR:-$HOME/.config}/functions(|-local)/**/[^_+]*(N^/:t) zmv edit-command-line 2>/dev/null

# zshmodules(1)
# zstyle ':completion:function:completer:command:arguments:tag'

zstyle ':prompt:arx:'               users             llua ecook arx root
zstyle ':prompt:arx:'               hosts             {netslum,megin-fi,caerleon-medb}.mac-anu.org
zstyle ':prompt:arx:'               primary-color     24
zstyle ':prompt:arx:'               secondary-color   45
zstyle ':prompt:arx:'               delimiter-color   219
zstyle ':prompt:arx:vcs_info:'      hosts             {netslum,sakubo,megin-fi}.mac-anu.org
# separate man page completion by section.
zstyle -e ':completion:*:manuals.*' insert-sections   'if [[ $OSTYPE = solaris* ]]; then reply=(false); else reply=(true); fi'
zstyle ':completion:*:manuals'      separate-sections true 
# per-match descriptions (if available)
zstyle ':completion:*'              verbose           true
# descriptions of commands (if available)
zstyle ':completion:*'              extra-verbose     true
# if a description isn't defined, use the option's description (from -h|--help)
zstyle ':completion:*'              auto-description  'specify: %d'
# default seperator between option -- description
zstyle ':completion:*'              list-separator    '::'
zstyle ':completion:*'              completer         _expand _complete _correct _approximate
# message telling you what you are completing
zstyle ':completion:*'              format            'Completing %d'
# group completions by type
zstyle ':completion:*'              group-name        ''
# if there are atleast 0 matches, use menu selection
zstyle ':completion:*'              menu              select
# COLOUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUURSSSSSSSSSSSS
zstyle ':completion:*:default'      list-colors       'ma=01;07;35' 'tc=01;36' "${(s.:.)ZLS_COLORS}"
# username completion
zstyle ':completion:*:(scp|ssh|rsync|sftp|qemu-system-*):*' \
                                    users             llua arx root
# hostname completion
zstyle ':completion:*:(scp|ssh|rsync|sftp|qemu-system-*):*' \
                                    hosts             umbra ansuz corbenik netslum nypumi caerleon-medb sakubo tarvos fidchell login1 login2
# completion of pids owned by $USER
zstyle ':completion:*:processes'    format            'Completing %d (pid user lstart %%%cpu %%%mem rss args)'
zstyle ':completion:*:processes'    command           'ps -o pid,user,lstart,pcpu,pmem,rss,args -A'
zstyle ':completion:*:nsenter:*:processes' \
                                    format            'Completing %d (pid command systemd-machined-id utsns netns mntns pidns ipcns userns)'
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
zstyle :completion::complete:-tilde-:: \
                                    group-order       named-directories users
zstyle ':completion:*:*:(lua|lua5[12]|lua-#5.[12]):*:*' \
                                    file-patterns     '*(-/):directories:directories *.(#i)lua(-.):globbed-files:lua\ scripts ^*.(#i)lua(-.):other-files:other\ files'
# avoiding _perl's restrictive _files glob
zstyle ':completion:*:*:perl:*:*'   file-patterns     '*(-/):directories:directories *.(p[ml]|PL|t)(-.):globbed-files:perl\ scripts *~*.(p[ml]|PL|t)(^/):other-files:other\ files'
zstyle ':completion::complete:perl:option-M-1:' \
                                    use-cache         true
zstyle ':completion::complete:salt(|-cp|-call):minions:' \
                                    cache-ttl         7 days
zstyle ':completion::complete:journalctl:option-b-1:' \
                                    sort              false
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
zstyle ':completion:*'              insert-tab        false
zstyle ':completion:*'              list-dirs-first   true
zstyle ':completion:*'              accept-exact      false
zstyle ':completion:*'              matcher-list      '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=* l:|=*'
zstyle ':completion:*'              select-prompt     %SScrolling active: current selection at %p%s
zstyle ':completion:*'              use-compctl       false
autoload -Uz compinit
compinit

# Prompt stuff
autoload -Uz promptinit; promptinit
prompt arx >/dev/null 2>&1

zle -C most-recent-file menu-complete _generic
# generate completions from gnu tool's --help
if [[ $OSTYPE == *linux* ]]; then
  for cmd in sed comm netstat tail head {z,e,f,}grep date auditctl virt-{install,clone,convert,xml} \
    lxc-{start,stop,create,clone,autostart,cgroup,checkconfig,console,destroy,device,execute,freeze,info,ls} \
    lxc-{monitor,snapshot,start-ephemeral,top,unfreeze,unshare,attach,top,usernsexec,wait}
  do
    compdef _gnu_generic $cmd
  done
  unset cmd
  if [[ -f /etc/arch-release ]]; then
    AUTOREMOVE() sudo pacman -R ${(of)"$(pacman -Qdtq)"}
    AUTOCLEAN() sudo pacman -Sc
  fi
fi

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
bindkey -v
bindkey -M viins -r '\e/'
bindkey -M vicmd 'd-d'                  kill-line
bindkey -M vicmd 'D'                    vi-kill-eol
bindkey -M vicmd 'K'                    run-help
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e.'                  insert-last-word
bindkey -M viins '\e^M'                 self-insert-unmeta
bindkey -M viins '^Xm'                  _most_recent_file
bindkey -M viins "^N"                   most-recent-file
bindkey -M viins '^Xh'                  _complete_help
bindkey -M viins '^X?'                  _complete_debug
bindkey -M viins '^P'                   push-line-or-edit
bindkey -M viins '^?'                   backward-delete-char
bindkey -M viins '^H'                   backward-delete-char
bindkey -M viins '\e[d'                 vi-backward-word
bindkey -M vicmd '\e[d'                 vi-backward-word
bindkey -M viins '^[OD'                 vi-backward-word
bindkey -M vicmd '^[OD'                 vi-backward-word
bindkey -M viins '\e[1;5D'              vi-backward-word
bindkey -M vicmd '\e[1;5D'              vi-backward-word
bindkey -M viins '\e[c'                 vi-forward-word
bindkey -M vicmd '\e[c'                 vi-forward-word
bindkey -M viins '^[OC'                 vi-forward-word
bindkey -M vicmd '^[OC'                 vi-forward-word
bindkey -M viins '\e[1;5C'              vi-forward-word
bindkey -M vicmd '\e[1;5C'              vi-forward-word
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
zle -N edit-command-line
bindkey -M viins '^E'                   edit-command-line
bindkey -M vicmd '^E'                   edit-command-line
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
bind2maps emacs             -- Right            forward-char
bind2maps emacs             -- urxvt-Right      forward-char
bind2maps       viins       -- BackSpace        backward-delete-char
bind2maps       viins       -- urxvt-BackSpace  backward-delete-char

stty start '' stop '' erase '^?'
unfunction bind2maps; unset key 

if autoload +X -z localrc 2>/dev/null; then
  localrc
fi
