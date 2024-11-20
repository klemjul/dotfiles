FROM ubuntu:22.04

RUN apt-get update
RUN apt-get -y install \
    git \
    zsh \
    curl \
    stow \
    sudo

RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser:password" | chpasswd
RUN usermod -aG sudo testuser

USER testuser

WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.dotfiles

CMD ["bash"]