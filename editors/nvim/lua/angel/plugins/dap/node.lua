-- lua/angel/plugins/dap/node.lua
-- Configuración moderna de DAP para Node.js / TypeScript usando vscode-js-debug

local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  return
end

local ok_js, dap_vscode_js = pcall(require, "dap-vscode-js")
if not ok_js then
  vim.notify("⚠️ No se encontró nvim-dap-vscode-js. Instálalo con Lazy o Mason.", vim.log.levels.WARN)
  return
end

-- Configuración del adaptador moderno (vscode-js-debug)
dap_vscode_js.setup({
  debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- o donde lo tengas instalado
  adapters = {
    "pwa-node",
    "pwa-chrome",
    "pwa-msedge",
    "pwa-extensionHost",
    "node-terminal",
  },
})

-- Configuraciones por lenguaje
for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "🟢 Ejecutar archivo actual",
      program = "${file}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "🧪 Ejecutar Jest en archivo actual",
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
        "${file}",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "🔌 Adjuntar a proceso Node",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "🌐 Depurar en Chrome (Next.js / React)",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
    },
  }
end
