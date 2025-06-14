return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters = {
        standardrb = {
          command = "standardrb",
          args = { "$FILENAME", "--fix" },
          stdin = true,
        },

        rubocop = {
          command = "bundle",
          args = { "exec", "rubocop", "--auto-correct", "--stdin", "$FILENAME", "--stderr", "--format", "files" },
          stdin = true,
        },

        yamlfix = {
          -- Change where to find the command
          command = "opt/homebrew/bin/yamlfix",
          -- Adds environment args to the yamlfix formatter
          env = {
            YAMLFIX_SEQUENCE_STYLE = "block_style",
          },
        },
      },

      formatters_by_ft = {
        -- JavaScript y derivados
        javascript = { "prettier" },        -- requiere: npm install -g prettier
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        vue = { "prettier" },

        -- Web
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        markdown = { "prettier" },          -- incluye doble comillas si se fuerza vía config prettier
        liquid = { "prettier" },

        -- Ruby
        ruby = { "rubocop" }, -- { "standardrb" },            -- requiere: gem install rubocop

        -- Python
        python = { "isort", "black" },      -- requiere: pip install black isort

        -- Lua
        lua = { "stylua" },                 -- requiere: brew install stylua

        -- Bash y Shell
        sh = { "shfmt" },                   -- requiere: brew install shfmt
        bash = { "shfmt" },

        -- C/C++
        c = { "clang_format" },             -- requiere: brew install clang-format
        cpp = { "clang_format" },

        -- Rust
        rust = { "rustfmt" },               -- requiere: rustup component add rustfmt

        -- Go
        go = { "gofmt" },                   -- viene con Go: go install

        -- Docker
        dockerfile = { "hadolint" },        -- requiere: brew install hadolint

        -- SQL
        sql = { "sqlfluff" },               -- requiere: pip install sqlfluff

        -- Protocol Buffers
        proto = { "buf" },                  -- requiere: brew install buf

        -- ERB (HTML embed en Ruby)
        erb = { "rubocop" }, -- { "standardrb" },             -- requiere: gem install erb-formatter

        -- Makefiles
        make = { "checkmake" },             -- requiere: go install github.com/mrtazz/checkmake@latest

        -- Terraform
        terraform = { "terraform_fmt" },    -- viene con Terraform: terraform fmt

        -- Dotenv
        dotenv = { "dotenv_linter" },       -- requiere: cargo install dotenv-linter

        -- Rakefiles, bin scripts
        rake = { "rubocop" },            -- reaprovecha el formatter de Ruby

        -- SVG
        svg = {}, -- No formatter universal, revisar `svglint` si querés integrarlo

        -- Mermaid (requiere integración a medida si querés `mermaid-lint`)
        -- mermaid = {},

        -- Fallback
        ["*"] = {}, -- catch-all
      },
    })

 vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.rb" },
      callback = function(args)
        conform.format({
          bufnr = args.buf,
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
