local keymapper = require("util.keymapper").mapper

local M = {}

-- Enable keybinds only for when lsp server available
-- Set keymaps on the active lsp server
M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymapper("<leader>fd", "Lspsaga finder", "n", opts) -- go to definition
	keymapper("<leader>gd", "Lspsaga peek_definition", "n", opts) -- peak definition
	keymapper("<leader>gD", "Lspsaga goto_definition", "n", opts) -- go to definition
	keymapper("<leader>ca", "Lspsaga code_action", "n", opts) -- see available code actions
	keymapper("<leader>rn", "Lspsaga rename", "n", opts) -- smart rename
	keymapper("<leader>D", "Lspsaga show_line_diagnostics", "n", opts) -- show  diagnostics for line
	keymapper("<leader>d", "Lspsaga show_cursor_diagnostics", "n", opts) -- show diagnostics for cursor
	keymapper("<leader>pd", "Lspsaga diagnostic_jump_prev", "n", opts) -- jump to prev diagnostic in buffer
	keymapper("<leader>nd", "Lspsaga diagnostic_jump_next", "n", opts) -- jump to next diagnostic in buffer
	keymapper("K", "Lspsaga hover_doc", "n", opts) -- show documentation for what is under cursor

	-- Set typescript specific vim.keymaps (e.g. rename file and update)

	-- Python
	if client.name == "pyright" then
		keymapper("<Leader>oi", "PyrightOrganizeImports", "n", opts)
	end
end

M.diagnostic_signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }

return M
