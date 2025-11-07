return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup()

    wk.register({
      { "<leader>g", group = " Git" },
      { "<leader>gh", group = " Hunk" },
      { "<leader>c", group = "🧹 Code / Format" },
      { "<leader>t", group = "🧪 Test" },
    })
  end,
}
