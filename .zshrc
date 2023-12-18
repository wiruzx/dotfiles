export ZSH="$HOME/.oh-my-zsh"

source "$HOME/.zshenv"

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

export ICLD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export DVL="$HOME/Developer"
export DOT="$HOME/Developer/other/dotfiles"
export IOS="$HOME/Developer/ios"
export CHSH="$HOME/Developer/other/cheatsheets"
export BDJR="$HOME/Developer/badoo-journal"

alias tre="tree -L 2"

# Emacs cask
export PATH="$HOME/.cask/bin:$PATH"

# Use brew ctags
alias ctags="`brew --prefix`/bin/ctags"

# Setup fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
