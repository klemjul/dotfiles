# dotfiles

Quickly set up my dev environment across different machines.

## Dependencies

- Zsh: Powerful, customizable shell with advanced features for scripting and interaction. [zsh.org](https://zsh.org)
- Git: Popular version control system for tracking and managing code changes. [git-scm.com](https://git-scm.com)
- Curl: Command-line tool for data transfers with support for multiple protocols. [curl.se](https://curl.se)
- GNU Stow: Symlink manager for organizing dotfiles or software packages. [gnu.org/software/stow](https://www.gnu.org/software/stow/)

## Getting Started

```sh
git clone https://github.com/klemjul/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash bootstrap.sh

mise tasks
mise run install-languages
mise run install-tools
mise run restore-vscode
mise run backup-vscode
```

## Getting Started with GitHub Codespaces

See [Dotfiles in GitHub Codespaces](https://docs.github.com/fr/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles)

```sh
# where dotfiles were pulled by GitHub and associated logs
cd /workspaces/.codespaces/.persistedshare/dotfiles

# Because zsh and git are already installed on GitHub env before dotfiles execute, we rerun it
rm -rf ~/.oh-my-zsh
rm ~/.gitconfig
bash bootstrap.sh

mise run install-languages
mise run install-tools
```

## Use of agentic development docker container

See [docker/agentic/README.md](docker/agentic/README.md)

# Testing with Docker

```sh
docker build -t dotfile-test-image .
docker run -it dotfile-test-image zsh
$ cd ~/.dotfiles
$ bash bootstrap.sh
```
