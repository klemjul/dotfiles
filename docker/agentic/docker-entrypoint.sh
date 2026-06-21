#!/bin/sh
set -e

# Start ssh-agent in the background, export SSH_AUTH_SOCK / SSH_AGENT_PID
eval "$(ssh-agent -s)"

# Hand off to whatever CMD/args were passed (zsh, or anything else)
exec "$@"