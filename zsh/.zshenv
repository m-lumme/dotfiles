# set XDG_CONFIG_HOME if not already set
# only set here to reuse it for ZDOTDIR
: ${XDG_CONFIG_HOME:=$HOME/.config}

# point zsh to additional config files
ZDOTDIR=$XDG_CONFIG_HOME/zsh
