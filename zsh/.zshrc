export DOTFILES_HOME="$HOME/.dotfiles"
if [[ "$(uname)" == "Darwin" ]]; then
  export APPLE_SSH_ADD_BEHAVIOR="macos"
fi
# ===== OH MY ZSH =====
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export EDITOR='code -w'

# ===== ALIAS =====
alias tf='terraform'


