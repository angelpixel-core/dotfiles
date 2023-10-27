return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = "williamboman/mason.nvim",
  event = "BufReadPre",
  opts = {
    ensure_installed = {
      "efm",

      -- Shell
      -- "bashls",
      -- "powershell_es",

      -- Editor
      -- "vimls",

      -- Lua
      "lua_ls",

      -- Web
      -- "html",
      -- "emmet_ls",
      -- "cssls",
      -- "tailwindcss",

      -- JavaScript
      -- "tsserver",
      -- "vuels",

      -- Data Mapping Standard
      -- "jsonls"
      -- "lemminx",
      -- "yamlls",

      -- Cucumber
      -- "cucumber_language_server",

      -- AWK
      -- "awk_ls",

      -- Arduino
      -- "arduino_language_server",

      -- Assembly
      -- "asm_lsp",

      -- C
      -- "clangd",

      -- Clojure
      -- "clojure_lsp",

      -- Docker
      -- "dockerls",
      -- "docker_compose_language_service"

      -- SQL
      -- "sqlls",

      -- GraphQL
      -- "graphql",

      -- Go
      -- "gopls"",

      -- Python
      -- "pyright",

      --  Ruby
      -- "ruby_ls",
      -- "solargraph",
      -- "sorbet",
      -- "standardrb",

      -- Rust
      -- "rust_analyzer",

      -- Smart Contracts
      -- "solidity",

      -- Terraform
      -- "tflint",

      -- Nix
      -- "nix_ls",

      -- Markdown
      -- "marksman",

      -- Java
      -- "java_language_server",
    },
    automatic_installation = true,
  },
}

