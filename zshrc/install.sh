#!/usr/bin/env bash

ln -fs $(pwd)/.zshrc ~/.zshrc

[ -f ~/.zshrc_secrets ] || echo "Missing ~/.zshrc_secrets!"
