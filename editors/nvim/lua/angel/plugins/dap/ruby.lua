-- lua/angel/plugins/dap/ruby.lua
-- Configuración del adaptador Ruby para nvim-dap (rdbg)

local ok, dap = pcall(require, "dap")
if not ok then
  return
end

dap.adapters.ruby = {
  type = "executable",
  command = "bundle",
  args = { "exec", "rdbg", "-n", "--open", "--port", "${port}", "-c", "--" },
}

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "Debug current Ruby file",
    request = "launch",
    program = "bundle",
    programArgs = function()
      return { "exec", "rspec", vim.fn.expand("%:p") }
    end,
    cwd = "${workspaceFolder}",
  },
  {
    type = "ruby",
    name = "Attach to Rails server",
    request = "attach",
    host = "127.0.0.1",
    port = 1234,
  },
}
