FROM ubuntu:24.04

RUN apt-get update
RUN apt-get -y install sudo

RUN useradd -m -s /bin/bash testuser && \
    echo "testuser:password" | chpasswd
RUN usermod -aG sudo testuser

USER testuser

WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.dotfiles

CMD ["bash"]