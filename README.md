# dotfiles

To use the configuration files and scripts from this repo on a Linux box:

```bash
git clone https://github.com/jranke/dotfiles
cd dotfiles
make
```

This will download the [vim-plug](https://github.com/junegunn/vim-plug) plugin
manager from github if not already present at .vim/autoload. To install the
plugins, open vim and type

```vim
:PlugInstall
```

For vim versions <= 7.4.1453 (but > 7.4) the legacy vim plugin
Vim-R-plugin version 1.2.8 will be configured for vim-plug.
To install the corresponding vimcom package from github, type

```bash
make vimcom
```
