return {
  -- airline
  { "vim-airline/vim-airline",
    init = function()
      vim.g.airline_powerline_fonts = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#branch#enabled"] = 1
      end,
  },
  { "vim-airline/vim-airline-themes",
    init = function()
      vim.g.airline_theme = 'wombat'
      end,
  }
}
