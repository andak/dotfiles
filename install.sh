#!/bin/bash

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/{i3,alacritty}

ln -s $(realpath vimrc) ~/.vimrc
ln -s $(realpath i3) ~/.config/i3/config
ln -s $(realpath alacritty.yml) ~/.config/alacritty/alacritty.yml

mkdir -p ~/repo
# Must-have programming fonts
git clone https://github.com/ryanoasis/nerd-fonts.git ~/repo/nerd-fonts
# Also check out: https://app.programmingfonts.org/
