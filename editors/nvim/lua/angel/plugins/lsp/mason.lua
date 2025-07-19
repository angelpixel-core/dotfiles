return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- Web
        "html",
        "cssls",
        "svelte",
        "tailwindcss",
        "tsserver",
        "emmet_ls",

        -- Lenguages
        "lua_ls",
        "ruby_lsp",
        "rust_analyzer",
        "pyright",

        -- DevOps
        "bashls",
        "dockerls",

        -- Markup
        "marksman",
        "jsonls",
        "yamlls",

        -- Database
        "prismals",
        "sqlls",
        "graphql",
      },
    })

    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "black",
        -- "isort", -- python formatter
        "rubocop",

        -- Linters
        "eslint_d",
        "pylint",

        -- DAP
        "debugpy", "node-debug2-adapter",
      },
    })

    -- local ruby_lspconfig = require("lspconfig").ruby_lsp
    -- ruby_lspconfig.setup({
    --   init_options = {
    --     formatter = "standard",
    --     linters = { "standard" },
    --   },
    -- })
  end,
}
