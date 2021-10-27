# dotfiles

These are my personal configuration files.

#Bootstrap Process

Dependencies: `git` and `GNU stow`
Deploy with the following commands:

```console
git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/m-lumme/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles/
stow -d "$HOME/.dotfiles/" -t "$HOME" -Sv */
```
