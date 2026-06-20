# opencode Agent Development Environment

A Docker image for running the [opencode](https://opencode.ai) agent locally with a pre-configured shell, dotfiles, and global agent skills.

## Building the image

```sh
docker build -t opencode-agent-dev .
```

## Environment variables

| Variable           | Description                      |
| ------------------ | -------------------------------- |
| `OPENCODE_API_KEY` | API key used by the opencode CLI |

### Build arguments

| Argument       | Default     | Description                                 |
| -------------- | ----------- | ------------------------------------------- |
| `USERNAME`     | `developer` | Non-root user created in the container      |
| `UID`          | `10001`     | User ID for the non-root user               |
| `GID`          | `10001`     | Group ID for the non-root user              |
| `DOTFILES_REF` | `master`    | Git ref to checkout from `klemjul/dotfiles` |

Example with a pinned dotfiles commit:

```sh
docker build --build-arg DOTFILES_REF=abc1234 -t opencode-agent-dev .
```

## Running

### Interactive TUI on the current directory

https://opencode.ai/docs/fr/tui/

```sh
docker run -it --rm \
  --name opencode-agent-dev \
  -e OPENCODE_API_KEY="$OPENCODE_API_KEY" \
  -v "$(pwd):/workspace" \
  -w /workspace \
  opencode-agent-dev \
  opencode
```

### Start a shell in the container

```sh
docker exec -it opencode-agent-dev /bin/zsh
```

### opencode web

https://opencode.ai/docs/web/

The image exposes port `4096` for the opencode web interface:

```sh
docker run -d \
  --name opencode-agent-dev \
  -p 4096:4096 \
  -e OPENCODE_API_KEY="$OPENCODE_API_KEY" \
  -e OPENCODE_SERVER_PASSWORD="$OPENCODE_SERVER_PASSWORD" \
  -v $(pwd):/workspace \
  -w /workspace \
  opencode-agent-dev \
  opencode web --hostname 0.0.0.0 --port 4096
```

### attach TUI to the opencode server

https://opencode.ai/docs/web/#attacher-un-terminal

```sh
docker exec -it opencode-agent-dev sh -c 'opencode attach localhost:4096'
```
