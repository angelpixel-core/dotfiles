return {
  -- "lifepillar/vim-solarized8",
  -- branch = "neovim",

  "Tsuzat/NeoSolarized.nvim",
  branch = "master",

  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.o.background = "dark"
    vim.cmd([[colorscheme NeoSolarized]])
  end,
}

