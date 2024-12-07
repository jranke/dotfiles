# dotfiles

To use the configuration files and scripts from this repo on a Linux box:

```bash
git clone https://github.com/jranke/dotfiles
cd dotfiles
make
```

If you have previously managed your vim plugins as in the former version of 
my dotfiles, i.e. using a link from the `.vim` directory to `.config/nvim`,
you need to remove that link before running `make`, as a new link from
`dotfiles/nvim` to `.config/nvim` will be created.
