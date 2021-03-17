#!/bin/bash

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
mv -f nvim.appimage /usr/bin/nvim

apt-get update
apt-get -y install ctags curl git inetutils-tools make nodejs npm python3 python3-pip zsh stow fzf

make ohmyzsh
make plugvim
make stow


wget -O MesloRegular.ttf  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 
wget -O MesloBold.ttf  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -O MesloBoldItalic.ttf  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
wget -O MesloItalic.ttf  https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf


mkdir -p ~/.local/share/fonts
mv MesloRegular.ttf ~/.local/share/fonts/MesloRegular.ttf
mv MesloBold.ttf ~/.local/share/fonts/MesloBold.ttf
mv MesloBoldItalic.ttf ~/.local/share/fonts/MesloBoldItalic.ttf
mv MesloItalic.ttf ~/.local/share/fonts/MesloItalic.ttf

nvim +PlugInstall +qall > /dev/null 
cd ~/.config/coc/extensions && npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
