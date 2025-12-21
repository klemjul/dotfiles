#!/usr/bin/env bash
set -euo pipefail

source utils.sh

OS=$(detect_os)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Validation results
PASSED=0
FAILED=0

validate_command() {
    local cmd="$1"
    local description="${2:-$cmd}"
    
    if command_exists "$cmd"; then
        echo -e "${GREEN}✓${NC} $description is installed"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description is NOT installed"
        ((FAILED++))
        return 1
    fi
}

validate_file() {
    local file="$1"
    local description="${2:-$file}"
    
    if [ -e "$file" ]; then
        echo -e "${GREEN}✓${NC} $description exists"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗${NC} $description does NOT exist"
        ((FAILED++))
        return 1
    fi
}


echo "Operating System: $OS"
echo ""

echo "Core Tools:"
validate_command "git" "Git" || true
validate_command "stow" "GNU Stow" || true
validate_command "zsh" "Zsh" || true
echo ""

echo "Installed Packages:"
validate_command "jq" "jq" || true
validate_command "age" "age" || true
validate_command "osv-scanner" "osv-scanner" || true
echo ""

if [ "$OS" = "macos" ]; then
    echo "macOS Specific:"
    validate_command "brew" "Homebrew"
    echo ""
fi

echo "Configuration Files:"
validate_file "$HOME/.gitconfig" "Git config"
validate_file "$HOME/.npmrc" "NPM config"
validate_file "$HOME/.zshrc" "Zsh config"
echo ""

echo "Shell Setup:"
validate_file "$HOME/.oh-my-zsh" "Oh My Zsh"
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo -e "${GREEN}✓${NC} zsh-autosuggestions plugin installed"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} zsh-autosuggestions plugin NOT installed"
    ((FAILED++))
fi
echo ""

echo "Mise Setup:"
MISE_PATH=$(command -v mise)
validate_file "$MISE_PATH" "Mise binary"
if grep -q "mise" "$HOME/.zshrc" 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Mise is configured in .zshrc"
    ((PASSED++))
else
    echo -e "${RED}✗${NC} Mise is NOT configured in .zshrc"
    ((FAILED++))
fi
echo ""

echo -e "${GREEN}Passed:${NC}   $PASSED"
echo -e "${RED}Failed:${NC}   $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All validations passed!${NC}"
    exit 0
else
    echo -e "${RED}Some validations failed. Please check the installation.${NC}"
    exit 1
fi
