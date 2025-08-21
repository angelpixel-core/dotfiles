local shell_script = vim.fn
local lazypath = shell_script.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",lazy
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local default_plugins = {
  spec = {
    { import = "angel.plugins" },
    { import = "angel.plugins.lsp" }
  }
}

local custom_opts = {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },

  rocks = {
    hererocks = true,
  }
}

require("lazy").setup(
  default_plugins,
  custom_opts
)
