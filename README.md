# Dotfiles

Personal dotfiles configuration for a portable development environment.

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

3. Restart your terminal or source the configuration:
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
- **Configuration**: Symlinks your config files to the appropriate locations

## Features

- **Modular Configuration**: Shell settings are organized in separate files
- **Fast Loading**: No installation checks in .zshrc - pure shell configuration
- **Portable**: Run `install.sh` once on any new machine
- **Clean Aliases**: Useful shortcuts for common commands
- **Enhanced History**: Better history search and management
- **Smart Completions**: Improved tab completion with styling

## Manual Re-setup

If you ever need to re-run the installation (e.g., after adding new tools), you can either:

```bash
# Re-run the install script
./install.sh

## How Symlinks Work

The `install.sh` script creates symlinks from your home directory to the files in this repository:

- `~/.zshrc` → `~/path/to/dotfiles/zsh/.zshrc`
- `~/.config/starship.toml` → `~/path/to/dotfiles/config/starship/starship.toml`
- `~/.config/ghostty/` → `~/path/to/dotfiles/config/ghostty/`

**This means you only edit files in the repository!** Changes are automatically reflected in your home directory through the symlinks.

## Making Changes

### ✅ **Correct Way** - Edit files in your dotfiles repository:
```bash
# Edit aliases
vim ~/path/to/dotfiles/zsh/aliases.zsh

# Edit main zsh config
vim ~/path/to/dotfiles/zsh/.zshrc

# Edit starship config
vim ~/path/to/dotfiles/config/starship/starship.toml
```

### ❌ **Wrong Way** - Don't edit the symlinked files directly:
```bash
# Don't do this - changes might get lost
vim ~/.zshrc
vim ~/.config/starship.toml
```

## Customization

- **Aliases**: Edit `zsh/aliases.zsh` in this repository
- **History settings**: Edit `zsh/history.zsh` in this repository  
- **Completions**: Edit `zsh/completions.zsh` in this repository
- **Main shell config**: Edit `zsh/.zshrc` in this repository
- **New tool installations**: Update `install.sh` in this repository

## Benefits of This Approach

- **Version Control**: All changes are tracked in git
- **Portability**: Easy to sync changes across machines
- **Backup**: Your configs are safely stored in the repository
- **Rollback**: Easy to revert changes using git
