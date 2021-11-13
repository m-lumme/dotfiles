## xdg
: ${XDG_CONFIG_HOME=$HOME/.config}
: ${XDG_CACHE_HOME=$HOME/.cache}
: ${XDG_DATA_HOME=$HOME/.local/share}
: ${XDG_STATE_HOME=$HOME/.local/state}

## history
if [ ! -d "$XDG_STATE_HOME/zsh" ]; then
    mkdir -p $XDG_STATE_HOME/zsh
fi
HISTFILE="$XDG_STATE_HOME/zsh/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

## options
# navigation
setopt AUTO_CD                  # cd only by folder name
setopt AUTO_PUSHD               # push cwd on dir stack after cd
setopt PUSHD_IGNORE_DUPS        # no duplicates on dir stack
setopt PUSHD_SILENT             # do not print dir stack after pushd popd

setopt CORRECT                  # activate spelling correction
setopt CDABLE_VARS              # cd to path stored in variable
setopt EXTENDED_GLOB            # extended globbing syntax

DIRSTACKSIZE=9                  # remember 9 directories in dir stack

# history
setopt EXTENDED_HISTORY         # ":start:elapsed;command" format for history
setopt SHARE_HISTORY            # share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # first expire duplicate commands when trimming
                                # the history
setopt HIST_IGNORE_DUPS         # do not record consecutive duplicate events
setopt HIST_IGNORE_ALL_DUPS     # first replace oldest duplicates
setopt HIST_FIND_NO_DUPS        # do not display duplicates in history search
setopt HIST_IGNORE_SPACE        # do not record commands that start with " "
setopt HIST_SAVE_NO_DUPS        # do not save duplicates to history file
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks
setopt INC_APPEND_HISTORY       # append to history file incrementally
setopt HIST_VERIFY              # do not execute history expansion immediately

# zle
setopt NO_BEEP                  # no error sounds in zle

# input/output
setopt INTERACTIVE_COMMENTS     # allow comments in interactive shell

# scripts/functions
setopt MULTIOS                  # implicit tees/cats for multiple redirections

# job control
setopt LONG_LIST_JOBS           # long format for job notifications

## completion
if [ ! -d "$XDG_STATE_HOME/zsh" ]; then
    mkdir -p $XDG_STATE_HOME/zsh
fi
# call compinit
# only update completion once a day
autoload -Uz compinit
if [[ -n $XDG_STATE_HOME/zsh/.zcompdump(#qN.mh+24) ]]; then
    compinit -d "$XDG_STATE_HOME/zsh/.zcompdump"
else
    compinit -C -d "$XDG_STATE_HOME/zsh/.zcompdump"
fi

# load complist for menu select
zmodload zsh/complist

# also perform completion on dotfiles
_comp_options+=(globdots)

# completion options
setopt AUTO_LIST                # list ambiguous choices
setopt GLOB_COMPLETE            # cycle through ambiguous options
setopt COMPLETE_IN_WORD         # complete mid word

# zstyle
# pattern: ":completion:<function>:<completer>:<command>:<argument>:<tag>"
# don't use old completion system
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list \
       'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# use cache
if [ ! -d "$XDG_CACHE_HOME/zsh" ]; then
    mkdir -p $XDG_CACHE_HOME/zsh
fi
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# configure completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %S%l%s
zstyle ':completion:*' format "Completing %d"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' special-dirs true

# completion colors
eval "$(dircolors)"
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# tweak kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# tweak cd
zstyle ':completion:*:*:cd:*' ignore-parents pwd

## aliases
if [ -f $ZDOTDIR/.zalias ]; then
    . $ZDOTDIR/.zalias
fi

## vim
# vi keybindings
bindkey -v
export KEYTIMEOUT=1

# convenient line navigation
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# edit current command line in vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

## plugins
ZPLUGDIR=$XDG_CONFIG_HOME/zsh/zplugins

# auto suggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source $ZPLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source $ZPLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history substring search
source $ZPLUGDIR/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## prompt
source $ZDOTDIR/.zprompt
