# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================

# History configuration
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Key bindings
bindkey ';3A' history-search-backward
bindkey ';3B' history-search-forward

# Vs code terminal compatibility
bindkey ';5A' history-search-backward
bindkey ';5B' history-search-forward
