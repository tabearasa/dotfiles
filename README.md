# Dotfiles

## Setup

```bash
#TBD
```

I made for all templates a fundamental definition. My personal machines run with the
username `tabula`. The machines, that are managed by a company or a third-party
which I only utilize for my work, won't be named like this.

## Personal Cheat Sheet

```bash
# Convert managed dotfile to a template
chezmoi chattr +template $FILE # must be "real dotfile"
```

## Personal Note

I thought, I had a good solution with GNU Stow and symlinking dotfiles, but I needed to
search for a solution, that can handle more and more requirements.

On that search, I found that `chezmoi` would fix my needs. If you ever wonder about a
dotfile solution, that handles specific needs of yours, I can really recommend
[this table](https://www.chezmoi.io/comparison-table/) for comparison purposes.

(Yeah, I know, that a comparison table provided by chezmoi in the context of dotfile management
libraries can be biased. If you found a better source: let me know.)
