FROM ubuntu

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install \
    ctags \
    curl \ 
    git \ 
    inetutils-tools \
    make \
    neovim \ 
    nodejs \
    npm \
    python3 \
    python3-pip \ 
    zsh \
    stow \
    fzf

RUN pip3 install pynvim

RUN mkdir -p /root/.dotfiles
COPY . /root/.dotfiles
RUN cd /root/.dotfiles && make

# Install neovim plugins
RUN nvim +PlugInstall +qall > /dev/null
RUN cd ~/.config/coc/extensions && npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# Set the workdir
WORKDIR /src
