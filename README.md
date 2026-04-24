# Dotfiles

My dotfile journal. These notes are for my future self, for a quick reference when setting up the next machine.

## Setup

```bash
# Install and already apply everything
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:tabearasa/dotfiles.git
```

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
```

## Personal Note

I thought, I had a good solution with GNU Stow and symlinking dotfiles, but I needed to
search for a solution, that can handle more and more requirements.

On that search, I found that `chezmoi` would fix my needs. If you ever wonder about a
dotfile solution, that handles specific needs of yours, I can really recommend
[this table](https://www.chezmoi.io/comparison-table/) for comparison purposes.

(Yeah, I know that a comparison table provided by chezmoi in the context of dotfile management
libraries can be biased. If you found a better source: let me know.)

