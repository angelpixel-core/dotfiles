return {
  "nvim-neotest/neotest",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
    "olimorris/neotest-rspec",
    "nvim-neotest/neotest-jest",
    "rouge8/neotest-rust",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({ dap = { justMyCode = false } }),
        require("neotest-rspec")(),
        require("neotest-jest")(),
        require("neotest-rust")(),
      },
      status = { virtual_text = true },
      summary = { open = "botright vsplit | vertical resize 80" },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          vim.cmd("copen")
        end,
      },
    })

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Keymaps para Neotest
    keymap(
      "n",
      "<leader>tt",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
      vim.tbl_extend("force", opts, { desc = "🧪 Run current test file" })
    )
    keymap(
      "n",
      "<leader>tr",
      "<cmd>lua require('neotest').run.run()<CR>",
      vim.tbl_extend("force", opts, { desc = "🧪 Run nearest test" })
    )
    keymap(
      "n",
      "<leader>ta",
      "<cmd>lua require('neotest').run.run({ suite = true })<CR>",
      vim.tbl_extend("force", opts, { desc = "🧪 Run all tests" })
    )
    keymap(
      "n",
      "<leader>tS",
      "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>",
      vim.tbl_extend("force", opts, { desc = "🐞 Debug test via DAP" })
    )
    keymap(
      "n",
      "<leader>to",
      "<cmd>lua require('neotest').output.open({ enter = true })<CR>",
      vim.tbl_extend("force", opts, { desc = "📤 Show test output" })
    )
    keymap(
      "n",
      "<leader>ts",
      "<cmd>lua require('neotest').summary.toggle()<CR>",
      vim.tbl_extend("force", opts, { desc = "📋 Toggle test summary" })
    )
  end,
}
