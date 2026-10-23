# Dotfiles

My dotfile journal. These notes are for my future self, when the next machine needs to be set up.

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/tabearasa/dotfiles/main/install.sh | sh
```

chezmoi clones this repo via HTTPS, so I don't need an SSH key for the first setup. But since
`autoPush` is on, I have to switch to SSH as soon as the key is there:

```sh
chezmoi git -- remote set-url origin git@github.com:tabearasa/dotfiles.git
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

(I don't need issues for this personal project, just a TODO list.)

* [ ] decide on local llm inference engine (ollama, llama.cpp, ...) and model configuration

