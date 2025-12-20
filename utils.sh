#!/usr/bin/env bash
set -euo pipefail

detect_os() {
    local os_type
    os_type=$(uname -s)
    
    if [ "$os_type" = "Linux" ]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            echo "${ID:-unknown}"
        else
            echo "unknown"
        fi
    elif [ "$os_type" = "Darwin" ]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

command_exists() {
    command -v "$1" &> /dev/null
}

install_packages() {
    if [ $# -eq 0 ]; then
        echo "Usage: install_packages <package1> [package2] ..."
        return 1
    fi
    
    local os
    os=$(detect_os)
    
    local packages_to_install=()
    for package in "$@"; do
        if command_exists "$package"; then
            echo "$package is already installed."
        else
            packages_to_install+=("$package")
        fi
    done
    
    if [ ${#packages_to_install[@]} -eq 0 ]; then
        echo "All packages are already installed."
        return 0
    fi
    
    echo "Installing: ${packages_to_install[*]}"
    
    case "$os" in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y "${packages_to_install[@]}"
            ;;
        macos)
            brew install "${packages_to_install[@]}"
            ;;
        *)
            echo "Unsupported OS: $os"
            return 1
            ;;
    esac
}
