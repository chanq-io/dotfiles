#!/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo -e "${GREEN}✓${RESET} ${BLUE}$target${RESET} already linked"
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}⚠${RESET}  ${BOLD}$target${RESET} exists but is not the expected symlink"
    else
        ln -s "$source" "$target"
        echo -e "${GREEN}✓${RESET} Created: ${BLUE}$target${RESET} → ${GREEN}$source${RESET}"
    fi
}
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
    local RESET='\033[0m' # No Color

    if ! brew ls --versions $cmd > /dev/null 2>&1; then
        echo -e "${YELLOW}Command '$cmd' not found. Installing via Homebrew...${RESET}"

        if ! command -v brew >/dev/null 2>&1; then
            install_brew
        fi

        if brew install "$package"; then
            echo -e "${GREEN}✓ Successfully installed '$package'${RESET}"
        else
            echo -e "${RED}✗ Failed to install '$package'${RESET}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ Command '$cmd' is already installed${RESET}"
    fi
}

brew_cask_install_if_missing() {
    local cask="$1"

    if brew list --cask | grep -q "^${cask}$" 2>/dev/null; then
        echo -e "${GREEN}✓ Cask    '$cask' is already installed${RESET}"
    else
        echo -e "${YELLOW}Cask '$cask' not found. Installing via Homebrew...${RESET}"

        if ! command -v brew >/dev/null 2>&1; then
            install_brew
        fi

        if brew install --cask "$cask"; then
            echo -e "${GREEN}✓ Successfully installed cask '$cask'${RESET}"
        else
            echo -e "${RED}✗ Failed to install cask '$cask'${RESET}"
            return 1
        fi
    fi
}

antidote_install_if_missing() {
    local plugin="$1"  # Use second argument as plugin name, or default to command name

    if ! grep -qs $plugin ~/.zsh_plugins.txt; then
        echo -e "${YELLOW}Command '$plugin' not found. Installing via Antidote...${RESET}"

        if [ ! -f "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh" ]; then
	    echo "ANTIDOTE MISSING"
            brew_install_if_missing antidote
            echo "source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh" >> ~/.zshrc
	    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
        fi

        if antidote install "$plugin"; then
            echo -e "${GREEN}✓ Successfully installed zsh plugin '$plugin'${RESET}"
        else
            echo -e "${RED}✗ Failed to install zsh plugin '$plugin'${RESET}"
            return 1
        fi
    else
        echo -e "${GREEN}✓ Plugin  '$plugin' is already installed${RESET}"
    fi
}

brew_install_rust() {
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
    fi
}

brew_install_starship (){
    brew_install_if_missing starship
    if ! grep -qs "starship init" ~/.zshrc; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    fi
}

brew_install_nvm (){
    brew_install_if_missing nvm
    if ! grep -qs "brew --prefix nvm" ~/.zshrc; then
        source $(brew --prefix nvm)/nvm.sh
        mkdir -p ~/.nvm
        echo 'source $(brew --prefix nvm)/nvm.sh' >> ~/.zshrc
        echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
        echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' >> ~/.zshrc
    fi
}

brew_install_uv (){
    brew_install_if_missing uv
    if [ ! -d "$HOME/.config/nvim_venv" ]; then
        uv venv ~/.config/nvim_venv
        source ~/.config/nvim_venv/bin/activate
        uv pip install pynvim
        deactivate
    fi
}

mkdir -p ~/.cargo ~/.config/

create_symlink "$HOME/.dotfiles/shell/zshrc" ~/.zshrc
create_symlink "$HOME/.dotfiles/ghostty/config" ~/.config/ghostty/config
create_symlink "$HOME/.dotfiles/cargo/config.toml" ~/.cargo/config.toml
create_symlink "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"

brew_install_if_missing ag
brew_install_if_missing bat
brew_install_if_missing chafa
brew_install_if_missing cmake
brew_install_if_missing eza
brew_install_if_missing fd
brew_install_if_missing ffmpeg
brew_install_if_missing fzf
brew_install_if_missing jq
brew_install_if_missing ueberzugpp jstkdng/programs/ueberzugpp
brew_install_if_missing llvm
brew_install_if_missing nvim
brew_install_if_missing podman
brew_install_if_missing rg
brew_install_if_missing tldr
brew_install_if_missing tree-sitter tree-sitter-cli
brew_install_if_missing utftex
brew_install_if_missing viu
brew_install_if_missing wget

brew_install_rust
brew_install_nvm
brew_install_starship
brew_install_uv

brew_cask_install_if_missing claude-code
brew_cask_install_if_missing font-fira-mono-nerd-font
brew_cask_install_if_missing ghostty
brew_cask_install_if_missing spotify

antidote_install_if_missing ael-code/zsh-colored-man-pages
antidote_install_if_missing alalik/pycalc
antidote_install_if_missing babarot/enhancd
antidote_install_if_missing jeffreytse/zsh-vi-mode
antidote_install_if_missing matthiasha/zsh-uv-env
antidote_install_if_missing zdharma-continuum/fast-syntax-highlighting
antidote_install_if_missing zsh-users/zsh-autosuggestions
