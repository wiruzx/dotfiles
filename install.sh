#!/bin/bash

dotfiles=(.zshrc .vimrc .emacs.d .config .fzf.zsh .ctags .tmux.conf)

for file in "${dotfiles[@]}"; do
    if [ -e ~/$file ]; then
        echo "File $file already exists, skipping"
        continue
    fi
    echo "Will create symlink for $file"
    ln -s $file ~/$file
done

echo "Done"
