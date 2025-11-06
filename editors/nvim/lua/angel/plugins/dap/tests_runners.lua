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
      local cwd = vim.fn.getcwd()

      if ext == "rb" then
        if file:match("_spec%.rb$") then
          run_test({
            type = "ruby",
            name = "RSpec current file",
            request = "launch",
            program = "bundle",
            programArgs = { "exec", "rspec", file },
            cwd = cwd,
          })
        else
          run_test({
            type = "ruby",
            name = "Minitest current file",
            request = "launch",
            program = "bundle",
            programArgs = { "exec", "ruby", file },
            cwd = cwd,
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
          type = "pwa-node",
          name = "JS/TS Jest test",
          request = "launch",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
            file,
          },
          rootPath = cwd,
          cwd = cwd,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        })
      elseif ext == "rs" then
        run_test({
          type = "codelldb",
          name = "Rust test current file",
          request = "launch",
          program = function()
            return vim.fn.input("Path to Rust test binary: ", cwd .. "/target/debug/", "file")
          end,
          cwd = cwd,
          args = { "--test", vim.fn.expand("%:t:r") },
          stopOnEntry = false,
        })
      else
        vim.notify("❌ No test runner configured for this file type: " .. ext, vim.log.levels.WARN)
      end
    end, { desc = "Run tests in current file via DAP" })

    vim.keymap.set("n", "<leader>tt", ":TestCurrentFile<CR>", { desc = "🧪 Run tests in current file" })
  end,
}
