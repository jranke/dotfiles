# dotfiles

To use the configuration files and scripts from this repo on a Linux box:

```bash
git clone https://github.com/jranke/dotfiles
cd dotfiles
make
```

The [install](install) script from this repository links
each configuration file from the dotfiles directory to a dotfile in the users
home directory.

If you have previously managed your vim plugins as in the former version of 
my dotfiles, i.e. using a link from the `.vim` directory to `.config/nvim`,
you need to remove that link before running `make`, as a new link from
`dotfiles/nvim` to `.config/nvim` will be created.

The install script also installs scripts from the bin directory into the users
`.local/bin` directory, and finally installs the
[vim-plug](https://github.com/junegunn/vim-plug) plugin manager from github if
not already present at .vim/autoload. To install the plugins, open vim and type

```vim
:PlugInstall
```
