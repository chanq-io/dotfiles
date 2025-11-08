#!/bin/zsh

install_brew (){
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew_install_if_missing() {
    local cmd="$1"
    local package="${2:-$1}"  # Use second argument as package name, or default to command name

    # Color codes
    local RED='\033[0;31m'
    local GREEN='\033[0;32m'
    local YELLOW='\033[0;33m'
    local NC='\033[0m' # No Color

    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${YELLOW}Command '$cmd' not found. Installing via Homebrew...${NC}"

        if ! command -v brew >/dev/null 2>&1; then
            install_brew
        fi

        if brew install "$package"; then
            echo -e "${GREEN}✓ Successfully installed '$package'${NC}"
        else
            echo -e "${RED}✗ Failed to install '$package'${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ Command '$cmd' is already installed${NC}"
    fi
}

brew_cask_install_if_missing() {
    local cask="$1"

    # Color codes
    local RED='\033[0;31m'
    local GREEN='\033[0;32m'
    local YELLOW='\033[0;33m'
    local NC='\033[0m' # No Color

    if brew list --cask | grep -q "^${cask}$" 2>/dev/null; then
        echo -e "${GREEN}✓ Cask    '$cask' is already installed${NC}"
    else
        echo -e "${YELLOW}Cask '$cask' not found. Installing via Homebrew...${NC}"

        if ! command -v brew >/dev/null 2>&1; then
            install_brew
        fi

        if brew install --cask "$cask"; then
            echo -e "${GREEN}✓ Successfully installed cask '$cask'${NC}"
        else
            echo -e "${RED}✗ Failed to install cask '$cask'${NC}"
            return 1
        fi
    fi
}

antidote_install_if_missing() {
    local plugin="$1"  # Use second argument as plugin name, or default to command name

    # Color codes
    local RED='\033[0;31m'
    local GREEN='\033[0;32m'
    local YELLOW='\033[0;33m'
    local NC='\033[0m' # No Color

    if ! grep -qs $plugin ~/.zsh_plugins.txt; then
        echo -e "${YELLOW}Command '$plugin' not found. Installing via Antidote...${NC}"

        if [ ! -f "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh" ]; then
	    echo "ANTIDOTE MISSING"
            brew_install_if_missing antidote
            echo "source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh" >> ~/.zshrc
	    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
        fi

        if antidote install "$plugin"; then
            echo -e "${GREEN}✓ Successfully installed zsh plugin '$plugin'${NC}"
        else
            echo -e "${RED}✗ Failed to install zsh plugin '$plugin'${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ Plugin  '$plugin' is already installed${NC}"
    fi
}

install_rust() {
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
    fi
}

install_starship (){
    brew_install_if_missing starship
    if ! grep -qs "starship init" ~/.zshrc; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    fi
}


mkdir -p ~/.cargo ~/.config
ln -s ~/.dotfiles/shell/zshrc ~/.zshrc
ln -s ~/.dotfiles/config/cargo/config.toml ~/.cargo
ln -s ~/.dotfiles/config/nvim ~/.config/nvim

brew_install_if_missing ag
brew_install_if_missing bat
brew_install_if_missing chafa
brew_install_if_missing cmake
brew_install_if_missing eza
brew_install_if_missing fd
brew_install_if_missing ffmpeg
brew_install_if_missing fzf
brew_install_if_missing jq
brew_install_if_missing nvim
brew_install_if_missing podman
brew_install_if_missing rg
brew_install_if_missing tldr
brew_install_if_missing uv
brew_install_if_missing viu

brew_cask_install_if_missing claude-code
brew_cask_install_if_missing font-fira-mono-nerd-font
brew_cask_install_if_missing ghostty
brew_cask_install_if_missing spotify

install_rust
install_starship

antidote_install_if_missing ael-code/zsh-colored-man-pages
antidote_install_if_missing alalik/pycalc
antidote_install_if_missing babarot/enhancd
antidote_install_if_missing jeffreytse/zsh-vi-mode
antidote_install_if_missing matthiasha/zsh-uv-env
antidote_install_if_missing zdharma-continuum/fast-syntax-highlighting
antidote_install_if_missing zsh-users/zsh-autosuggestions
