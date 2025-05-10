return {
  "3rd/image.nvim",
  dependencies = { "luarocks.nvim" },
  config = function()
    require("image").setup({
      backend = "ueberzug", -- or "kitty"
      max_height_window_percentage = 50,
      -- hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    })
  end,
}
