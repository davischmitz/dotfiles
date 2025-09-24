# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

export KUBECONFIG="$HOME/.kube/kubeconfig.yaml:$HOME/.kube/dev-mcp-app-foundation.yaml:$HOME/.kube/test-mcp-app-foundation.yaml"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$HOME/hdlfscli/bin:$PATH"

# =============================================================================
# ZINIT SETUP
# =============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# =============================================================================
# LOAD MODULAR CONFIGURATIONS
# =============================================================================

# Get the directory where this .zshrc file is located (resolve symlinks)
ZSHRC_FILE="${(%):-%N}"
if [[ -L "$ZSHRC_FILE" ]]; then
    # If it's a symlink, get the actual file path
    ZSHRC_DIR="$(cd "$(dirname "$(readlink "$ZSHRC_FILE")")" && pwd)"
else
    # If it's not a symlink, get the directory normally
    ZSHRC_DIR="$(cd "$(dirname "$ZSHRC_FILE")" && pwd)"
fi

# Source modular configuration files
source "$ZSHRC_DIR/aliases.zsh"
source "$ZSHRC_DIR/history.zsh"
source "$ZSHRC_DIR/completions.zsh"

# =============================================================================
# CONVENIENCE FUNCTIONS
# =============================================================================

# Function to re-run dotfiles setup
dotfiles-setup() {
    local dotfiles_dir="$(cd "$ZSHRC_DIR/.." && pwd)"
    if [[ -f "$dotfiles_dir/install.sh" ]]; then
        echo "🔄 Running dotfiles setup from $dotfiles_dir..."
        "$dotfiles_dir/install.sh"
    else
        echo "❌ Could not find install.sh in $dotfiles_dir"
        return 1
    fi
}

# =============================================================================
# TOOL INITIALIZATIONS
# =============================================================================

# FZF
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# Starship
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Carapace (load after completions are initialized)
if command -v carapace &> /dev/null; then
    source <(carapace _carapace)
fi

# Zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init - zsh)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDKMAN - THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
