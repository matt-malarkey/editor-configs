#!/usr/bin/env bash

ln -fs $(pwd)/.gitconfig ~/.gitconfig

mkdir -p ~/dev
ln -fs $(pwd)/.gitconfig-personal ~/dev/.gitconfig-personal

mkdir -p ~/code
ln -fs $(pwd)/.gitconfig-work ~/code/.gitconfig-work

# Github setup
if command -v gh &>/dev/null; then
  gh config set editor "vim"
fi

# Global gitignore config
if [ ! -f ~/.gitignore ]; then
  printf ".idea\n*.iml\n.DS_Store\n.remote\n" > ~/.gitignore
  git config --global core.excludesfile ~/.gitignore
fi

