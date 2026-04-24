# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## What This Repository Is

A personal dotfiles repository managed by [chezmoi](https://chezmoi.io). Chezmoi copies (not symlinks) files from this source directory into the home directory, applying templates along the way.

## Common Commands

```bash
# Apply changes from this repo to the home directory
chezmoi apply

# Preview what changes would be made
chezmoi diff

# Add/update a managed dotfile
chezmoi add ~/.some_dotfile

# Convert an existing managed file to a template
chezmoi chattr +template $FILE   # file must be the "real" dotfile path

# Test template rendering without applying
chezmoi execute-template < $TEMPLATE_FILE

# Edit a managed file and apply immediately
chezmoi edit --apply ~/.some_dotfile
```

## Repository Architecture

### File Naming Conventions (chezmoi)

- `dot_` prefix → becomes `.` in the home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `.tmpl` suffix → processed as a Go template before being written
- `run_onchange_before_*.sh` → scripts that re-run only when their content changes, before applying dotfiles
- Files in `.chezmoiscripts/linux/` → only executed on Linux

### Machine Differentiation

Two variables control machine-type behavior (set interactively at first `chezmoi init`):

| Variable | Purpose |
|---|---|
| `chezmoi.username == "tabula"` | Personal machine (used directly in templates) |
| `company_computer` | String `"y"` or `"n"` (stored in chezmoi data) |

Personal-only features gated behind these checks: Alacritty (built from source), Obsidian AppImage, KeePassXC secret management.

### Template Data Variables

Defined in `.chezmoi.toml.tmpl` and prompted once at init:

- `github_name`, `github_email` — personal GitHub identity
- `git_work_name`, `work_email` — work git identity
- `company_computer` — `"y"` / `"n"` flag
- `keepassxc_db` — path to the KeePassXC `.kdbx` database file (used for secret management)

### External Dependencies

Managed in `.chezmoiexternal.toml` — chezmoi downloads and places these automatically:

- `~/.oh-my-zsh` — Oh My Zsh (archive, refreshes weekly)
- `~/.oh-my-bash` — Oh My Bash (git-repo, refreshes weekly)
- `~/.oh-my-zsh/custom/themes/powerlevel10k` — pinned at v1.20.0
- `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` / `zsh-autosuggestions` — weekly refresh
- `~/.config/tmux/plugins/catppuccin/tmux` and `tmux-cpu` — git-repos, monthly refresh

### Installation Scripts (`.chezmoiscripts/linux/`)

Scripts run in alphabetical order; all are `run_onchange_before_*` so they re-trigger only when their content changes:

| Script | What it does |
|---|---|
| `run_onchange_before_install_packages.sh.tmpl` | `apt` installs core tools (tmux, git, neovim, zsh, curl, etc.) |
| `run_onchange_before_install_alacritty.sh.tmpl` | Builds Alacritty from source via Cargo (personal machines only) |
| `run_onchange_before_install_font.sh` | Downloads and installs FiraCode Nerd Font |
| `run_onchange_before_install_uv.sh` | Installs `uv` Python package manager |
| `run_onchange_before_install_vscode.sh` | Adds Microsoft apt repo and installs VS Code Insiders |
| `run_onchange_before_install_appimages.sh.tmpl` | Installs Obsidian AppImage (personal machines only) |

### Key Dotfiles

| Source file | Target | Notes |
|---|---|---|
| `dot_zshrc` | `~/.zshrc` | Oh My Zsh, Powerlevel10k, auto-starts tmux |
| `dot_bashrc.tmpl` | `~/.bashrc` | Oh My Bash fallback shell |
| `dot_aliases` | `~/.aliases` | Shared aliases sourced by both shells |
| `dot_gitconfig.tmpl` | `~/.gitconfig` | Switches identity by directory via `includeIf` |
| `dot_gitconfig_personal.tmpl` | `~/.gitconfig_personal` | Personal identity for `~/github/` |
| `dot_tmux.conf.tmpl` | `~/.tmux.conf` | Catppuccin theme, CPU plugin, custom keybindings |
| `dot_config/alacritty/` | `~/.config/alacritty/` | FiraCode font, terminal settings |

### KeePassXC Secret Management

On personal machines (`company_computer != "y"`), chezmoi is configured to use KeePassXC via `keepassxc-cli` for secret management. The `[keepassxc]` section in `.chezmoi.toml.tmpl` points to the user's `.kdbx` database.

To use secrets in templates:

```
{{ (keepassxc "Entry Title").Password }}
{{ keepassxcAttribute "Entry Title" "AttributeName" }}
```

`keepassxc-cli` will prompt for the database password once per chezmoi session.
