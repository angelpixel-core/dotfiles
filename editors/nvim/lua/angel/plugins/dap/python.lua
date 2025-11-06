-- lua/angel/plugins/dap/python.lua
-- Configuración DAP para Python (usando debugpy)

local ok, dap = pcall(require, "dap")
if not ok then
  return
end

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch current Python file",
    program = "${file}",
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      else
        return "python"
      end
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to process",
    processId = require("dap.utils").pick_process,
  },
}
