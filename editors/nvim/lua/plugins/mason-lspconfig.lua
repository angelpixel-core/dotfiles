return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = "williamboman/mason.nvim",
  event = "BufReadPre",
  opts = {
    ensure_installed = {
      "efm",
      "bashls",
      "tsserver",
      "solidity",
      "tailwindcss",
      "pyright",
      "html",
      "cssls",
      "lua_ls",
      "emmet_ls",
      "jsonls",
    },
    automatic_installation = true,
  },
}

