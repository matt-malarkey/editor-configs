#!/bin/dash

# Following https://docs.open.ch/docs/display/DEV/Git+and+Stash+User+Guide

git config --global user.name 'Matt Malarkey'
git config --global user.email 'mmalarkey@open-systems.com'

# Optional
git config --global color.ui auto
git config --global core.editor 'vim'
git config --global core.pager 'less -F -X'
git config --global url.ssh://git@stash.open.ch:7999/.insteadOf https://stash.open.ch/scm/
# git config --global alias.st status

# Git primer config
git config --global merge.ff false 
git config --global merge.commit false
git config --global branch.autosetuprebase always
git config --global push.default simple

git config --global pull.rebase true

# Github setup
if command -v gh &>/dev/null; then
  gh config set editor "vim"
fi

# Global gitignore config
if [ ! -f ~/.gitignore ]; then
  printf ".idea\n*.iml\n.DS_Store\n.remote\n" > ~/.gitignore
  git config --global core.excludesfile ~/.gitignore
fi

