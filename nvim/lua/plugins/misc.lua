return {
  
  -- pandoc
  { "vim-pandoc/vim-pandoc" },
  { "vim-pandoc/vim-pandoc-syntax" },
  
  -- kwbdi
  --[[ The following plugin gives me <Leader>bd for closing a buffer while keeping
       the window open, for example when editing several R scripts with
       the R interpreter running in a separate vim window ]]
  { "seb-mueller/kwbdi.vim" },

  -- Version control
  { "tpope/vim-fugitive" },
  { "airblade/vim-gitgutter" },
  { "samoshkin/vim-mergetool",
    init = function()
        vim.g.mergetool_layout = 'mr'
        vim.g.mergetool_prefer_revision = 'local'
      end,
  },

  -- Show an manage marks
  { "kshenoy/vim-signature" },

  -- Wayland clipboard
  { "jasonccox/vim-wayland-clipboard" },
  
  -- vimcmdline
  { "jalvesaq/vimcmdline",
    init = function()
        vim.b.cmdline_map_start = '<LocalLeader>s'
      end,
  },

  -- fzf
  { "junegunn/fzf" },

  -- Look up docs in vim scripts with 'K'
  { "tpope/vim-scriptease" },

  -- Delete trailing whitespace
  { "vim-scripts/DeleteTrailingWhitespace" }
}
