# dotfiles

These are my personal configuration files.

# Simple Bootstrap Process

Dependencies: `git` and `GNU stow`.

Deploy with the following commands:

```console
git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/m-lumme/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/
stow -d ~/.dotfiles/ -t ~ -Sv */
```

# Bootstrap Process for Contribution

Dependencies: correct `ssh key`, `git` and `GNU stow`.

Deploy with the following commands:

```console
git clone --recurse-submodules --shallow-submodules git@github.com:m-lumme/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow -d ~/.dotfiles/ -t ~ -Sv */
git config submodule.recurse 1
git config status.submodulesummary 1
```
