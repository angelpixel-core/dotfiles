local dap = require("dap")

-- Adaptador: conecta Neovim con el debugger Ruby (rdbg)
dap.adapters.ruby = {
  type = "executable",
  command = "bundle",
  args = {
    "exec", "rdbg",
    "-n",           -- no stop en inicio
    "--open",       -- acepta conexiones
    "--port", "${port}",
    "-c",           -- continúa ejecución
    "--",
    "bundle", "exec", "rails", "s"
  },
}

-- Configuraciones predefinidas
dap.configurations.ruby = {
  {
    type = "ruby",
    request = "launch",
    name = "Debug current RSpec file",
    program = "bundle",
    programArgs = function()
      return { "exec", "rspec", vim.fn.expand("%:p") }
    end,
  },
  {
    type = "ruby",
    request = "attach",
    name = "Attach to running Rails",
    remoteHost = "127.0.0.1",
    remotePort = "3000",
  },
}
