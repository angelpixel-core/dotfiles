return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/lazy.nvim" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")
    local devicons = require("nvim-web-devicons")

    -- 🧭 Obtener ruta relativa al root del repo Git (fallback: cwd)
    local function relative_git_filepath()
      local path = vim.fn.expand("%:p")
      if path == "" then
        return "[No Name]"
      end

      local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      if git_root == nil or git_root == "" then
        git_root = vim.fn.getcwd()
      end

      local relpath = vim.fn.fnamemodify(path, ":." .. git_root)
      return relpath
    end

    -- 🎨 Mostrar ícono + path con color dinámico
    local function file_with_icon()
      local filename = vim.fn.expand("%:t")
      local ext = vim.fn.expand("%:e")
      local icon, icon_color = devicons.get_icon_color(filename, ext, { default = true })
      local filepath = relative_git_filepath()

      -- Colorear el ícono dinámicamente
      vim.api.nvim_set_hl(0, "LualineFileIconDynamic", { fg = icon_color, bg = "NONE" })

      return string.format("%%#LualineFileIconDynamic#%s %%#Normal#%s", icon, filepath)
    end

    -- 🎨 Colores base (puedes adaptar al theme que uses)
    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }

    -- 🪄 Tema visual
    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = { a = { bg = colors.green, fg = colors.bg, gui = "bold" } },
      visual = { a = { bg = colors.violet, fg = colors.bg, gui = "bold" } },
      replace = { a = { bg = colors.red, fg = colors.bg, gui = "bold" } },
      command = { a = { bg = colors.yellow, fg = colors.bg, gui = "bold" } },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.fg },
        c = { bg = colors.inactive_bg, fg = colors.fg },
      },
    }

    -- ⚙️ Setup LuaLine
    lualine.setup({
      options = {
        theme = my_lualine_theme,
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "dashboard", "NvimTree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          {
            file_with_icon,
            separator = { left = "", right = "" },
            padding = { left = 1, right = 1 },
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding", fmt = string.upper },
          { "fileformat", icons_enabled = true },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "nvim-tree" },
    })
  end,
}
