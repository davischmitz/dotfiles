#!/bin/bash

# Dotfiles Installation Script
# Run this once to set up all required tools and dependencies

set -e  # Exit on any error

echo "🚀 Starting dotfiles setup..."

# Function to install Homebrew if not present
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "🍺 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "✅ Homebrew already installed"
    fi
}

# Function to check if a brew package is installed
is_brew_package_installed() {
    local package_name=$(basename "$1")
    brew list "$package_name" &> /dev/null
}

# Function to install required packages via brew
install_brew_packages() {
    local packages=(
        "fzf"
        "starship"
        "carapace"
        "eza"
        "k9s"
        "zoxide"
        "pipenv"
        "lazydocker"
    )
    
    local missing_packages=()
    
    # Check which packages are missing
    for package in "${packages[@]}"; do
        if ! is_brew_package_installed "$package"; then
            missing_packages+=("$package")
        fi
    done
    
    # Install missing packages
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        echo "📦 Installing missing packages: ${missing_packages[*]}"
        for package in "${missing_packages[@]}"; do
            echo "Installing $(basename "$package")..."
            brew install "$package"
        done
    else
        echo "✅ All brew packages already installed"
    fi
}

# Function to install SDKMAN if not present
install_sdkman() {
    if [[ ! -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
        echo "☕ Installing SDKMAN..."
        curl -s "https://get.sdkman.io" | bash
    else
        echo "✅ SDKMAN already installed"
    fi
}

# Function to install NVM if not present
install_nvm() {
    if [[ ! -s "$HOME/.nvm/nvm.sh" ]]; then
        echo "📦 Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    else
        echo "✅ NVM already installed"
    fi
}

# Function to install pyenv if not present
install_pyenv() {
    if ! command -v pyenv &> /dev/null; then
        echo "🐍 Installing pyenv..."
        brew install pyenv
    else
        echo "✅ pyenv already installed"
    fi
}

# Function to install FiraCode Nerd Font
install_firacode_font() {
    # Check if FiraCode Nerd Font is already installed
    if ls ~/Library/Fonts/*FiraCode* &> /dev/null || ls /Library/Fonts/*FiraCode* &> /dev/null; then
        echo "✅ FiraCode Nerd Font already installed"
        return
    fi
    
    echo "🔤 Installing FiraCode Nerd Font..."
    
    # Add the nerd-fonts tap if not already added
    brew tap homebrew/cask-fonts 2>/dev/null || true
    
    # Install FiraCode Nerd Font
    brew install --cask font-fira-code-nerd-font
    
    echo "✅ FiraCode Nerd Font installed"
}

# Function to set up symlinks for config files
setup_config_symlinks() {
    echo "🔗 Setting up config file symlinks..."
    
    # Get the directory where this script is located
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Create config directories if they don't exist
    mkdir -p "$HOME/.config"
    
    # Symlink config files
    if [[ -d "$DOTFILES_DIR/config/ghostty" ]]; then
        ln -sfn "$DOTFILES_DIR/config/ghostty" "$HOME/.config/ghostty"
        echo "✅ Linked ghostty config"
    fi
    
    if [[ -d "$DOTFILES_DIR/config/starship" ]]; then
        ln -sfn "$DOTFILES_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"
        echo "✅ Linked starship config"
    fi
    
    # Symlink zsh config
    if [[ -f "$DOTFILES_DIR/zsh/.zshrc" ]]; then
        ln -sfn "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
        echo "✅ Linked .zshrc"
    fi
}

# Main installation function
main() {
    echo "🚀 Running dotfiles installation..."
    
    # Install core tools
    install_homebrew
    install_brew_packages
    install_sdkman
    install_nvm
    install_pyenv
    install_firacode_font
    
    # Set up configuration symlinks
    setup_config_symlinks
    
    echo ""
    echo "✅ Dotfiles setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Your dotfiles are now configured and ready to use!"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
