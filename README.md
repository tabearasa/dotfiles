# Dotfiles

My dotfile journal. These notes are for my future self, for a quick reference when setting up the next machine.

## Setup

```bash
sudo apt-get update && sudo apt-get install -y curl git
export PATH="$HOME/.local/bin:$PATH"
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin" init --apply tabearasa
```

The init clones via HTTPS, so no SSH key is needed. Because `autoPush` is enabled, switch the
remote to SSH once a key is set up:
`chezmoi git -- remote set-url origin git@github.com:tabearasa/dotfiles.git`

All templates share a common base definition. The tools I use for work and personal
development can differ, so I defined the chezmoi custom data field `company_computer`
to integrate this accordingly as a Go template.

## (Personal) Cheat Sheet

```bash
# Pull latest changes from remote and apply
chezmoi update

# Convert managed dotfile to a template
chezmoi chattr +template $FILE # must be "real dotfile"

# Test template
chezmoi execute-template < $TEMPLATE_FILE

# Re-add a modified file from the target state (with safety mechanisms)
# Useful for NVIM
chezmoi re-add
```

## Personal Note

I thought, I had a good solution with GNU Stow and symlinking dotfiles, but I needed to
search for a solution, that can handle more and more requirements.

On that search, I found that `chezmoi` would fix my needs. If you ever wonder about a
dotfile solution, that handles specific needs of yours, I can really recommend
[this table](https://www.chezmoi.io/comparison-table/) for comparison purposes.

(Yeah, I know that a comparison table provided by chezmoi in the context of dotfile management
libraries can be biased. If you found a better source: let me know.)

## TODOs

I don't need issues for this personal project, just a TODO list.

* [ ] write potential feature about removing deleted files from externally managed repos? `deleted file mode 100644`?
* [ ] add git lfs

