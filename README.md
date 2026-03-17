# Dotfiles

My dotfile journal. These lines are for my future self, if I need to get a quick heads up
for the next to be initialized machine.

## Setup

```bash
# Install and already apply everythin
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:tabearasa/dotfiles.git
```

I made for all templates a fundamental definition. My personal machines run with the
username `tabula`. The machines, that are managed by a company or a third-party
which I only utilize for my work, won't be named like this.

## Personal Cheat Sheet

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

(Yeah, I know, that a comparison table provided by chezmoi in the context of dotfile management
libraries can be biased. If you found a better source: let me know.)

# TODOS

* [ ] install keepassxc and utilize passwords
