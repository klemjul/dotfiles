FROM ubuntu:22.04

RUN apt-get update
RUN apt-get -y install \
    git \
    zsh \
    curl \
    stow

RUN useradd -m -s /bin/zsh testuser 

USER testuser

WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.dotfiles

CMD ["bash"]