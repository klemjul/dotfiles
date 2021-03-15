.PHONY : \
	echo1 \
	echo2 

.DEFAULT_GOAL := stow

STOW_DIRS = $(shell ls -1 dotfiles)
STOW_TARGETS =  $(addprefix stow_, $(STOW_DIRS))

$(STOW_TARGETS): stow_%:
	stow --target=${HOME} --dir=dotfiles $(subst stow_,,$@)

stow: $(STOW_TARGETS) plugvim

makefi: echo1 echo2
	echo $(STOW_TARGETS)

plugvim:
	@curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo1:
	echo "bonjour 1"

echo2:
	echo "bonjour 2"

