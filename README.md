# dotfiles

Quickly set up my dev environment across different machines.

# Dependencies

- Zsh: Powerful, customizable shell with advanced features for scripting and interaction. [zsh.org](https://zsh.org)
- Git: Popular version control system for tracking and managing code changes. [git-scm.com](https://git-scm.com)
- Curl: Command-line tool for data transfers with support for multiple protocols. [curl.se](https://curl.se)
- GNU Stow: Symlink manager for organizing dotfiles or software packages. [gnu.org/software/stow](https://www.gnu.org/software/stow/)

# Gettings Started

```sh
git clone https://github.com/klemjul/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash boostrap.sh
```

# Testing with Docker

```sh
docker build -t dotfile-test-image .
docker run -it dotfile-test-image zsh
$ cd ~/.dotfiles
$ bash bootstrap.sh
```
