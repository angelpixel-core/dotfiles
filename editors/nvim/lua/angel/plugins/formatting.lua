-- Archivo: lua/angel/plugins/formatting.lua
-- Configuración de formateo automático usando conform.nvim

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- Mapa de filetypes a formateadores
      formatters_by_ft = {
        lua = { "stylua" },
        -- Web / frontend
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        -- Ruby / Rails
        ruby = { "rubocop" },
        -- Python
        python = { "isort", "black" },
        -- Todos los otros filetypes pueden heredar aquí si lo deseas
        ["*"] = { "trim_whitespace" },
      },

      -- Opciones generales de formato
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },

      -- Formatear **antes** de guardar
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- Mapear un atajo manual para formatear el archivo actual
    vim.keymap.set("n", "<leader>cf", function()
      require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
    end, { desc = "Format current file" })
  end,
}
