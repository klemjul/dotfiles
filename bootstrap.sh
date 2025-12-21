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
else
    echo "Oh My Zsh is already installed."
fi

# install zsh-autosuggestions plugin https://github.com/zsh-users/zsh-autosuggestions/tree/master
if [ ! -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]; then
    echo "Install zsh-autosuggestions plugin from package manager..."
    install_packages zsh-autosuggestions
    
    if [ "$OS" = "macos" ]; then
        ZSH_AUTOSUGGESTIONS_PATH="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    else
        ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
    
    mkdir -p "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    ln -s "$ZSH_AUTOSUGGESTIONS_PATH" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    # shellcheck disable=SC2016
    echo 'source ${0:A:h}/zsh-autosuggestions.zsh' >> "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
else
    echo "zsh-autosuggestions plugin is already configured."
fi


# install mise
if [ ! -e "$HOME/.local/bin/mise" ]; then
    echo "Mise is not installed. Installing from package manager..."
    curl https://mise.run | sh

    if [ "$OS" = "debian" ] || [ "$OS" = "ubuntu" ]; then
        sudo apt update -y && sudo apt install -y curl
        sudo install -dm 755 /etc/apt/keyrings
        curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.pub 1> /dev/null
        echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    fi

    install_packages mise

    printf "\n%s\n" "# ===== MISE =====" >> "$DOTFILES_HOME/zsh/.zshrc"
    eval "$HOME/.local/bin/mise activate zsh" >> "$DOTFILES_HOME/zsh/.zshrc"
else
    echo "Mise is already installed."
fi