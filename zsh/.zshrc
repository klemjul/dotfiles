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
alias agent-dev='docker run -it --rm \
  --name opencode-agent-dev \
  -e OPENCODE_API_KEY="$OPENCODE_API_KEY" \
  -v $(pwd):/workspace \
  -v ~/.ssh/klemjulbot:/home/developer/.ssh:ro \
  -w /workspace \
  opencode-agent-dev
'

