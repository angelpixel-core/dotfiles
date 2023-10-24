local shell_script = vim.fn
local lazypath = shell_script.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  shell_script.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local default_plugins = {
  spec = {
    { import = "plugins" }
  }
}

local custom_opts = {}

require("lazy").setup(default_plugins, custom_opts)

