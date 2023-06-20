# dotfiles

To use the configuration files and scripts from this repo on a Linux box:

```bash
git clone https://github.com/jranke/dotfiles
cd dotfiles
make
```

This will call the [install](install) script from this repository, which links
each configuration file from the dotfiles directory to a dotfile in the users
home directory.

Also, it links vim configuration files to the respective
nvim configuration files, installs the official git prompt,
installs scripts from the bin directory into the users
bin directory, and finally installs the
[vim-plug](https://github.com/junegunn/vim-plug) plugin manager from github if
not already present at .vim/autoload. To install the plugins, open vim and type

```vim
:PlugInstall
```
