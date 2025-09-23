# =============================================================================
# COMPLETION CONFIGURATION
# =============================================================================

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:' menu no
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# Load completions
autoload -Uz compinit && compinit
