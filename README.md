# Dotfiles

## Quick Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Restart the terminal or source the configuration:
   ```bash
   source ~/.zshrc
   ```

## Structure

```
dotfiles/
├── install.sh              # One-time setup script
├── README.md               # This file
├── zsh/
│   ├── .zshrc             # Main shell configuration
│   ├── aliases.zsh        # Command aliases
│   ├── history.zsh        # History settings & key bindings
│   └── completions.zsh    # Completion configuration
└── config/
    ├── ghostty/           # Ghostty terminal config
    └── starship/          # Starship prompt config
```

## What Gets Installed

The `install.sh` script will install:

- **Homebrew** (macOS package manager)
- **CLI Tools**: fzf, starship, eza, k9s, zoxide, pipenv, lazydocker, carapace
- **Development Tools**: SDKMAN, NVM, pyenv
- **Font**: FiraCode Nerd Font
- **Configuration**: Symlinks your config files to the appropriate locations

## Features

- **Modular Configuration**: Shell settings are organized in separate files
- **Portable**: Run `install.sh` once on any new machine
- **Enhanced History**: Better history search and management
- **Smart Completions**: Improved tab completion with styling

## Manual Re-setup

If you ever need to re-run the installation (e.g., after adding new tools), you can either:

```bash
# Re-run the install script
./install.sh

## How Symlinks Work

The `install.sh` script creates symlinks from the home directory to the files in this repository:

- `~/.zshrc` → `~/path/to/dotfiles/zsh/.zshrc`
- `~/.config/starship.toml` → `~/path/to/dotfiles/config/starship/starship.toml`
- `~/.config/ghostty/` → `~/path/to/dotfiles/config/ghostty/`

