#!/bin/bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage /usr/bin/nvim

apt-get update
apt-get -y install ctags curl git inetutils-tools make nodejs npm python3 python3-pip zsh stow fzf


make ohmyzsh
make plugvim
make stow


nvim +PlugInstall +qall > /dev/null 
cd ~/.config/coc/extensions && npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod