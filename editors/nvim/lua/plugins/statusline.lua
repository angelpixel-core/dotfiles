return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    local theme = require("lualine.themes.NeoSolarized")

    -- set bg transparency in all modes
    theme.normal.c.bg = nil
    theme.insert.c.bg = nil
    theme.visual.c.bg = nil
    theme.replace.c.bg = nil
    theme.command.c.bg = nil

    require("lualine").setup({
      options = {
        theme = theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" }
      },
      sections = {
        lualine_a = {
          {
            "mode",
          },
        },
        lualine_b = {
          {
            "filename",
            newfile_status = true,
            path = 1,
          },
        },
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {
          { "branch" },
          {
            "diff",
            colored = true, -- Displays a colored diff status if set to true
            symbols = { added = '+', modified = '~', removed = '-' },
          },
        },
        lualine_z = {
          {
            "diagnostics",
            sections = { 'error', 'warn', 'info', 'hint' },
          },
        },
      },
      inactive_sections = {
        lualine_a = {
          {
            "filename",
            newfile_status = true,
            path = 1,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
