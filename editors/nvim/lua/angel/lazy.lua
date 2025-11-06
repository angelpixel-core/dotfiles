-- lua/angel/lazy.lua
-- Bootstrap y configuración principal de lazy.nvim
local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Si no existe, clona lazy.nvim
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- usa la rama estable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins por defecto (importa todos los módulos en lua/angel/plugins)
local default_plugins = {
  spec = {
    { import = "angel.plugins" }, -- importará todos los archivos en lua/angel/plugins/*.lua
    { import = "angel.plugins.lsp" }, -- si tienes submódulos allí
  },

  -- Control de performance y cheks
  defaults = {
    lazy = true, -- por defecto todos los plugins serán cargados de forma lazy a menos que especifiques lo contrario
    version = nil, -- usa nil si quieres la última versión (fija en lockfile si necesitas estabilidad)
  },

  -- Opciones de checker (busca updates)
  checker = {
    enabled = true,
    notify = false,
  },

  change_detection = {
    notify = false,
  },

  dev = {
    path = vim.fn.stdpath("config") .. "/lua", -- si trabajas plugins locales
    fallback = true,
  },

  -- Optimización: rutas de runtime a ignorar para mejorar startup
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(default_plugins)
