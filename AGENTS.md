# AGENTS.md

A personal dotfiles repository managed by [chezmoi](https://chezmoi.io). Chezmoi copies (not symlinks) files from this source directory into the home directory, applying templates along the way.

## Warning: chezmoi auto-commits and auto-pushes

`.chezmoi.toml.tmpl` sets `[git] autoCommit = true` and `autoPush = true`. Every chezmoi command that modifies the source directory (`chezmoi add`, `chezmoi edit`, `chezmoi chattr`, `chezmoi forget`, `chezmoi re-add`) commits the **entire working tree**, including unrelated uncommitted work, under a generated message, and then pushes it to GitHub.

Agents must not run these commands. Create or edit files in this source directory directly (e.g. `cp ~/.profile dot_profile`), and leave committing to the user. Only the read-only commands above are safe.

## Common Commands

Read-only, safe for agents:

```bash
# Preview what changes would be made
chezmoi diff

# Test template rendering without applying
chezmoi execute-template < $TEMPLATE_FILE

# Show the rendered target of a managed file
chezmoi cat ~/.some_dotfile

# Check which targets are managed or ignored (e.g. after editing .chezmoiignore)
chezmoi managed
chezmoi ignored
```

User only (see the warning below):

```bash
# Apply changes from this repo to the home directory
chezmoi apply

# Add/update a managed dotfile
chezmoi add ~/.some_dotfile

# Convert an existing managed file to a template
chezmoi chattr +template $FILE   # file must be the "real" dotfile path

# Edit a managed file and apply immediately
chezmoi edit --apply ~/.some_dotfile
```

## Repository Architecture

### File Naming Conventions (chezmoi)

- `dot_` prefix → becomes `.` in the home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- `.tmpl` suffix → processed as a Go template before being written
- `run_onchange_before_*.sh` → scripts that re-run only when their content changes, before applying dotfiles
- Files in `.chezmoiscripts/linux/` → only executed on Linux
- Any other file in the repo root (no `dot_` prefix, no leading `.`) is copied to `~` as is, so repo-only files (`README.md`, `AGENTS.md`, `CLAUDE.md`, `install.sh`) must be listed in `.chezmoiignore`. `.chezmoiignore` is itself a template and also holds the machine-specific ignores
- `.chezmoiremove` → targets chezmoi deletes from `~` (files that were dropped from the repo, e.g. `.bash_profile`)

### Machine Differentiation

One variable controls machine-type behavior (set interactively at first `chezmoi init`):

| Variable | Purpose |
|---|---|
| `company_computer` | String `"y"` or `"n"` (stored in chezmoi data) |

Personal-only features gated behind `{{ if ne .company_computer "y" }}`: Alacritty (built from source), Homebrew, Obsidian AppImage, the Nerd Font install, and KeePassXC secret management.

### Template Data Variables

Defined in `.chezmoi.toml.tmpl` and prompted once at init:

- `github_name`, `github_email` — personal GitHub identity (`github_name` doubles as the GitHub login in the gitconfig remote patterns; `github_email` is the GitHub noreply address)
- `git_work_name`, `work_email` — work git identity
- `company_computer` — `"y"` / `"n"` flag
- `keepassxc_db` — path to the KeePassXC `.kdbx` database file (used for secret management)
- `work_git_host` — host of the work git server (e.g. `gitlab.example.com`), only prompted on company computers. Never write the real value into this repo
- `install_freecad`, `install_blender`, `install_kicad`, `install_darktable`, `install_btop`, `install_brave` — booleans, only prompted on personal machines; the packages script installs each app that was answered with yes

### External Dependencies

Managed in `.chezmoiexternal.toml` — chezmoi downloads and places these automatically:

- `~/.oh-my-zsh` — Oh My Zsh (archive, refreshes weekly)
- `~/.oh-my-bash` — Oh My Bash (git-repo, refreshes weekly)
- `~/.oh-my-zsh/custom/themes/powerlevel10k` — pinned at v1.20.0
- `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` / `zsh-autosuggestions` — weekly refresh
- `~/.config/tmux/plugins/catppuccin/tmux`, `~/.config/tmux/plugins/cpu` and `~/.config/tmux/plugins/battery` — git-repos, monthly refresh (`battery` is downloaded but not currently loaded by `dot_tmux.conf`)
- `~/.zplug` — zplug, git-repo, monthly refresh (downloaded but not referenced by any dotfile)

### Bootstrap Script (`install.sh`)

Run once on a fresh machine, before chezmoi exists (`curl ... | sh`, POSIX sh): installs `git`, installs chezmoi to `~/.local/bin` and runs `chezmoi init --apply tabearasa`. Listed in `.chezmoiignore`, so it is not copied to `~`.

### Installation Scripts (`.chezmoiscripts/linux/`)

Scripts run in alphabetical order; all are `run_onchange_before_*` so they re-trigger only when their content changes:

| Script | What it does |
|---|---|
| `run_onchange_before_00_install_packages.sh.tmpl` | Runs first: `apt-get update`, then installs core tools (tmux, git, make, zsh, curl, docker.io, etc.) |
| `run_onchange_before_install_alacritty.sh.tmpl` | Builds Alacritty from source via Cargo (personal machines only) |
| `run_onchange_before_install_font.sh.tmpl` | Downloads and installs FiraCode Nerd Font (personal machines only) |
| `run_onchange_before_install_linuxbrew.sh.tmpl` | Installs Homebrew (personal machines only) |
| `run_onchange_before_install_mitmproxy.sh.tmpl` | Installs pinned mitmproxy standalone binaries (`MITMPROXY_VERSION`) to `~/.local/bin`; on WSL also prints how to trust the CA in Windows |
| `run_onchange_before_install_neovim.sh` | Installs the latest Neovim release tarball to `/opt` and symlinks `/usr/local/bin/nvim` (apt's neovim is too old for LazyVim); skipped if `nvim` >= 0.11.2 |
| `run_onchange_before_install_pnpm.sh` | Installs the `pnpm` package manager |
| `run_onchange_before_install_pyenv.sh` | Installs `pyenv` to `~/.pyenv` via pyenv.run (build deps come from the packages script) |
| `run_onchange_before_install_uv.sh` | Installs `uv` Python package manager |
| `run_onchange_before_install_vscode.sh.tmpl` | Adds Microsoft apt repo and installs VS Code Insiders (skipped on WSL) |
| `run_onchange_before_install_appimages.sh.tmpl` | Installs Obsidian AppImage (personal machines only) |

### Key Dotfiles

| Source file | Target | Notes |
|---|---|---|
| `dot_zshrc` | `~/.zshrc` | Oh My Zsh, Powerlevel10k, auto-starts tmux |
| `dot_bashrc.tmpl` | `~/.bashrc` | Oh My Bash fallback shell |
| `dot_aliases` | `~/.aliases` | Shared aliases sourced by both shells |
| `dot_profile` | `~/.profile` | Login PATH (`~/bin`, `~/.local/bin`, pyenv shims); POSIX sh only |
| `dot_xsessionrc` | `~/.xsessionrc` | Sourced by Debian's Xsession (`set -e`); sources `~/.profile` so GUI apps get the PATH. Only installed where `/etc/X11/Xsession` exists (`.chezmoiignore`) |
| `dot_gitconfig.tmpl` | `~/.gitconfig` | No global identity (`user.useConfigOnly`); picks the identity by remote URL via `includeIf "hasconfig:remote.*.url:..."` |
| `dot_gitconfig_personal.tmpl` | `~/.gitconfig_personal` | Personal identity for `github.com/<github_name>/` remotes |
| `dot_gitconfig_work.tmpl` | `~/.gitconfig_work` | Work identity for `work_git_host` remotes; company computers only (`.chezmoiignore`) |
| `dot_p10k.zsh`, `dot_p10k.colors.zsh` | `~/.p10k.zsh`, `~/.p10k.colors.zsh` | Powerlevel10k prompt config |
| `dot_tmux.conf` | `~/.tmux.conf` | Catppuccin theme, CPU plugin, custom keybindings |
| `dot_config/alacritty/` | `~/.config/alacritty/` | FiraCode font, terminal settings |
| `dot_config/nvim/` | `~/.config/nvim/` | LazyVim; own plugin specs in `lua/plugins/`. `lazy-lock.json` is intentionally not tracked |
| `dot_agents/skills/` | `~/.agents/skills/` | Agent skills shared by all coding agents; `dot_agents/dot_skill-lock.json` tracks the skills installed from GitHub |
| `dot_claude/symlink_skills.tmpl` | `~/.claude/skills` | Symlink to `~/.agents/skills`, so Claude Code uses the same skills |

### KeePassXC Secret Management

On personal machines (`company_computer != "y"`), chezmoi is configured to use KeePassXC via `keepassxc-cli` for secret management. The `[keepassxc]` section in `.chezmoi.toml.tmpl` points to the user's `.kdbx` database.

To use secrets in templates:

```
{{ (keepassxc "Entry Title").Password }}
{{ keepassxcAttribute "Entry Title" "AttributeName" }}
```

`keepassxc-cli` will prompt for the database password once per chezmoi session.
