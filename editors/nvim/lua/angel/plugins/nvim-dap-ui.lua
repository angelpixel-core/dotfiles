return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local neodev = require("neodev")

    neodev.setup({
      library = {
        plugins = { "nvim-dap-ui" },
        types = true,
      },
    })
  end,
}
