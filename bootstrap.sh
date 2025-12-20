#!/bin/bash

source utils.sh

OS=$(detect_os)
DOTFILES_HOME="$HOME/.dotfiles"
ls $DOTFILES_HOME


# Install Homebrew on macOS if not present
if [ "$OS" = "macos" ] && ! command_exists brew; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    if [ "$OS" = "macos" ]; then
        echo "Homebrew is already installed."
    fi
fi

install_packages zsh stow git curl

if [ ! -e "$HOME/.gitconfig" ]; then
    stow git
else
    echo "$HOME/.gitconfig already present."
fi

if [ ! -e "$HOME/.npmrc" ]; then
    stow npm
else
    echo "$HOME/.npmrc already present."
fi


# install oh my zsh and set .zshrc config
if [ ! -e "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # delete generated configuration
    rm "$HOME/.zshrc"
    stow zsh

    # oh my zsh plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
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