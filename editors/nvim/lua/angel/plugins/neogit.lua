return {
  "NeogitOrg/neogit",
  keys = {
    { "<leader>gs", ":Neogit<CR>", desc = "Neogit status", silent = true },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("neogit").setup({
      filewatcher = { enabled = false },
    })
  end,
}
