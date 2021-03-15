.PHONY : \
	ohmyzsh \
	plugvim \
	stow

	

.DEFAULT_GOAL := main

STOW_DIRS = $(shell ls -1 dotfiles)
STOW_TARGETS =  $(addprefix stow_, $(STOW_DIRS))

OHM_PLUGS = ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
			            ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

OHM_THEMES = ~/.oh-my-zsh/custom/themes/powerlevel9k \
			              ~/.oh-my-zsh/custom/themes/powerlevel10k

main: stow plugvim ohmyzsh

$(STOW_TARGETS): stow_%:
	stow --target=${HOME} --dir=dotfiles $(subst stow_,,$@)

stow: $(STOW_TARGETS)

plugvim: 
	@curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ohmyzsh: ~/.oh-my-zsh $(OHM_PLUGS) $(OHM_THEMES)

~/.oh-my-zsh:
		@if [ ! -d $@ ]; then git clone https://github.com/ohmyzsh/ohmyzsh $@; fi

~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting:
		@if [ ! -d $@ ]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $@; fi

~/.oh-my-zsh/custom/plugins/zsh-autosuggestions:
		@if [ ! -d $@ ]; then git clone https://github.com/zsh-users/zsh-autosuggestions.git $@; fi

~/.oh-my-zsh/custom/themes/powerlevel10k:
		@if [ ! -d $@ ]; then git clone https://github.com/romkatv/powerlevel10k.git $@; fi

~/.oh-my-zsh/custom/themes/powerlevel9k:
		@if [ ! -d $@ ]; then git clone https://github.com/Powerlevel9k/powerlevel9k.git $@; fi


