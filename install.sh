#!/bin/sh

## Neovim
mkdir -p ~/.config/nvim
ln -s $(realpath vimrc) ~/.config/nvim/init.vim
