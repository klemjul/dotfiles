#!/bin/bash
DOTFILES_HOME="$HOME/.dotfiles"

# git config
stow git

# install oh my zsh and set .zshrc config
if [ ! -e "$DOTFILES_HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # delete generated configuration
    rm "$HOME/.zshrc"
    stow zsh

    # oh my zsh plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "Oh My Zsh is already installed."
fi

# install mise
if [ ! -e "$HOME/.local/bin/mise" ]; then
    echo "Mise is not installed. Installing..."
    curl https://mise.run | sh
    printf "\n%s\n" "# ===== MISE =====" >> "$DOTFILES_HOME/zsh/.zshrc"
    eval "$HOME/.local/bin/mise activate zsh" >> "$DOTFILES_HOME/zsh/.zshrc"
else
    echo "Mise is already installed."
fi