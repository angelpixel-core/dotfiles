-- return {
--   -- "folke/tokyonight.nvim",
--   "Tsuzat/NeoSolarized.nvim",
--   branch = "master",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000,
--   config = function()
--     local transparent = true
--
--     local bg = "#011628"
--     local bg_dark = "#011423"
--     local bg_highlight = "#143652"
--     local bg_search = "#0A64AC"
--     local bg_visual = "#275378"
--     local fg = "#CBE0F0"
--     local fg_dark = "#B4D0E9"
--     local fg_gutter = "#627E97"
--     local border = "#547998"
--
--     -- require("tokyonight").setup({
--     require("NeoSolarized").setup({
--       -- style = "night",
--       transparent = transparent,
--       styles = {
--         sidebars = transparent and "transparent" or "dark",
--         floats = transparent and "transparent" or "dark",
--       },
--       on_colors = function(colors)
--         colors.bg = bg
--         colors.bg_dark = transparent and colors.none or bg_dark
--         colors.bg_float = transparent and colors.none or bg_dark
--         colors.bg_highlight = bg_highlight
--         colors.bg_popup = bg_dark
--         colors.bg_search = bg_search
--         colors.bg_sidebar = transparent and colors.none or bg_dark
--         colors.bg_statusline = transparent and colors.none or bg_dark
--         colors.bg_visual = bg_visual
--         colors.border = border
--         colors.fg = fg
--         colors.fg_dark = fg_dark
--         colors.fg_float = fg
--         colors.fg_gutter = fg_gutter
--         colors.fg_sidebar = fg_dark
--       end,
--     })
--
--     -- vim.cmd("colorscheme tokyonight")
--     vim.cmd("colorscheme NeoSolarized")
--   end,
-- }
--
-- -- lua/angel/plugins/colorscheme.lua
return {
  "Tsuzat/NeoSolarized.nvim",
  lazy = false, -- carga siempre en startup
  priority = 1000,
  config = function()
    local transparent = true
    local theme = require("NeoSolarized")

    theme.setup({
      transparent = transparent,
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        colors.bg = "#011628"
        colors.bg_dark = transparent and colors.none or "#011423"
        colors.bg_float = transparent and colors.none or "#011423"
        colors.bg_highlight = "#143652"
        colors.bg_popup = "#011423"
        colors.bg_search = "#0A64AC"
        colors.bg_sidebar = transparent and colors.none or "#011423"
        colors.bg_statusline = transparent and colors.none or "#011423"
        colors.bg_visual = "#275378"
        colors.border = "#547998"
        colors.fg = "#CBE0F0"
        colors.fg_dark = "#B4D0E9"
        colors.fg_float = "#CBE0F0"
        colors.fg_gutter = "#627E97"
        colors.fg_sidebar = "#B4D0E9"
      end,
    })

    vim.cmd("colorscheme NeoSolarized")
  end,
}
