# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

_fzf_compgen_path() {
  fd . "$1"
}

_fzf_compgen_dir() {
  fd --type d . "$1"
}

# Appearance
# ----------
export FZF_DEFAULT_OPTS="--height=40% --no-clear"

