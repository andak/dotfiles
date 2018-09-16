#!/bin/bash

## Neovim
# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/{nvim,i3,alacritty,polybar}

ln -s $(realpath vimrc) ~/.config/nvim/init.vim
ln -s $(realpath i3) ~/.config/i3/config
ln -s $(realpath alacritty.yml) ~/.config/alacritty/alacritty.yml
ln -s $(realpath polybar) ~/.config/polybar/config
ln -s $(realpath launch_polybar.sh) ~/.config/polybar/launch_polybar.sh
