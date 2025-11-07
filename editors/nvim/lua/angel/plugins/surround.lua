return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- stable
  config = function()
    require("nvim-surround").setup()
  end,
}
