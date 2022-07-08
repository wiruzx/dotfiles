export ZSH="$HOME/.oh-my-zsh"

unsetopt prompt_cr prompt_sp

ZSH_THEME="minimal"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line

# Emacs style
zle -N edit-command-line
bindkey '^v' edit-command-line

alias gla="glog --all"
alias gdc="gd --cached"

export ICLD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"
export BMBL="$HOME/Developer/ios/bumble/master"
export BMB="$HOME/Developer/ios/bumble"
export CHTT="$HOME/Developer/ios/Chatto"
export DVL="$HOME/Developer"
export DOT="$HOME/Developer/other/dotfiles"
export IOS="$HOME/Developer/ios/"

alias tre="tree -L 2"

# Emacs cask
export PATH="$HOME/.cask/bin:$PATH"

# Pyenv support
eval "$(pyenv init -)"

# Use brew ctags
alias ctags="`brew --prefix`/bin/ctags"

# Setup fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
