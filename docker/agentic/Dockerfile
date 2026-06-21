# ubuntu:24.04
FROM ubuntu@sha256:786a8b558f7be160c6c8c4a54f9a57274f3b4fb1491cf65146521ae77ff1dc54


ARG USERNAME=developer
ARG UID=10001
ARG GID=10001
# Build-time only — doesn't leak into the running container's environment
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=UTC

# Basic environment
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    sudo \
    zsh \
    openssh-client \
    gnupg \
    tini \
    locales \
    libatomic1 \
 && rm -rf /var/lib/apt/lists/*

# Locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Non-root user
RUN groupadd -g ${GID} ${USERNAME} \
  && useradd -m -u ${UID} -g ${GID} \
    -s /bin/zsh \
    ${USERNAME} \
  && usermod -aG sudo ${USERNAME} \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
  && chmod 440 /etc/sudoers.d/${USERNAME}

# Some basic hardening
RUN passwd -d ${USERNAME} \
  && chmod 700 /home/${USERNAME} \
  && echo 'umask 027' >> /etc/profile

USER ${USERNAME}
WORKDIR /home/${USERNAME}

#
# Install dotfiles — pinned to a specific commit
#
ARG DOTFILES_REF=master
RUN git clone https://github.com/klemjul/dotfiles.git ~/.dotfiles \
  && cd ~/.dotfiles \
  && git checkout ${DOTFILES_REF} \
  && bash bootstrap.sh \
  && mise run install-tools \
  && mise run install-languages
COPY git/.gitconfig /home/${USERNAME}/.gitconfig

#
# Install global npm tools (including opencode, skills) reproducibly via lockfile
# (package.json + package-lock.json)
#
WORKDIR /home/${USERNAME}/.global-npm-tools
COPY --chown=${USERNAME}:${USERNAME} package.json package-lock.json ./
RUN mise x -- npm ci --omit=dev
RUN cd node_modules/opencode-ai && mise x -- node postinstall.mjs
ENV PATH="/home/${USERNAME}/.global-npm-tools/node_modules/.bin:/home/${USERNAME}/.local/bin:/home/${USERNAME}/.opencode/bin:${PATH}"
WORKDIR /home/${USERNAME}

#
# Global Skills
#
RUN mise x -- skills add https://github.com/mattpocock/skills \
  --skill writing-great-skills \
  --agent opencode \
  --global \
  --yes

RUN mise x -- skills add https://github.com/vercel-labs/skills \
  --skill find-skills \
  --agent opencode \
  --global \
  --yes

#
# Runtime configuration
#
ENV OPENCODE_SERVER_USERNAME=developer
ENV OPENCODE_PORT=4096

# in case of opencode web is used
EXPOSE 4096

COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["/bin/zsh"]