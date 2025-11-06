-- lua/angel/plugins/dap/tests_runners.lua
-- Permite ejecutar tests con DAP para Ruby, Python, JS/TS y Rust usando <leader>tt

return {
  "mfussenegger/nvim-dap",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local dap = require("dap")

    local function run_test(config)
      dap.run(config)
    end

    vim.api.nvim_create_user_command("TestCurrentFile", function()
      local ext = vim.fn.expand("%:e")
      local file = vim.fn.expand("%:p")

      if ext == "rb" then
        if string.match(file, "_spec%.rb$") then
          run_test({
            type = "ruby",
            name = "RSpec current file",
            request = "launch",
            program = "bundle",
            programArgs = { "exec", "rspec", file },
            cwd = "${workspaceFolder}",
          })
        else
          run_test({
            type = "ruby",
            name = "Minitest current file",
            request = "launch",
            program = "bundle",
            programArgs = { "exec", "ruby", file },
            cwd = "${workspaceFolder}",
          })
        end
      elseif ext == "py" then
        run_test({
          type = "python",
          name = "Python current file",
          request = "launch",
          program = file,
          pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
              return venv .. "/bin/python"
            else
              return "python"
            end
          end,
        })
      elseif ext == "js" or ext == "ts" then
        run_test({
          type = "node2",
          name = "JS/TS current file",
          request = "launch",
          program = "node",
          args = { "node_modules/jest/bin/jest.js", file },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        })
      elseif ext == "rs" then
        run_test({
          type = "codelldb",
          name = "Rust test current file",
          request = "launch",
          program = function()
            return vim.fn.input("Path to Rust test executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          args = { "--test", vim.fn.expand("%:t:r") },
          stopOnEntry = false,
        })
      else
        print("No test runner configured for file type: " .. ext)
      end
    end, { desc = "Run tests in current file via DAP" })

    vim.keymap.set("n", "<leader>tt", ":TestCurrentFile<CR>", { desc = "Run tests in current file" })
  end,
}
