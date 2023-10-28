local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})

	local lspconfig = require("lspconfig")

	-- Editor Signs
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- Lua
	lspconfig.lua_ls.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			-- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files through global "vim"
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

  -- Ruby
  lspconfig.solargraph.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
    autoformat = true,
  })

	-- Python
	lspconfig.pyright.setup({
		-- capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
      "python",
		},

		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},

		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
			},
		},
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim", -- or you can use null-ls for Linting
		"folke/neoconf.nvim",
	},
}

--[[
local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- json
	-- lspconfig.jsonls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	filetypes = { "json", "jsonc" },
	-- })

	-- typescript
	-- lspconfig.tsserver.setup({
	-- 	on_attach = on_attach,
	-- 	capabilities = capabilities,
	-- 	filetypes = {
	-- 		"typescript",
	-- 	},
	-- 	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	-- })

	-- bash
	-- lspconfig.bashls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	filetypes = { "sh" },
	-- })

	-- solidity
	-- lspconfig.solidity.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	filetypes = { "solidity" },
	-- })

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	-- lspconfig.emmet_ls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	filetypes = {
	-- 		"html",
	-- 		"typescriptreact",
	-- 		"javascriptreact",
	-- 		"javascript",
	-- 		"css",
	-- 		"sass",
	-- 		"scss",
	-- 		"less",
	-- 		"svelte",
	-- 		"vue",
	-- 	},
  -- })

	-- docker
	-- lspconfig.dockerls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- })

	-- local eslint_d = require("efmls-configs.linters.eslint_d")
	-- local prettierd = require("efmls-configs.formatters.prettier_d")
	-- local fixjson = require("efmls-configs.formatters.fixjson")
	-- local shellcheck = require("efmls-configs.linters.shellcheck")
	-- local shfmt = require("efmls-configs.formatters.shfmt")
	-- local alex = require("efmls-configs.linters.alex")
	-- local hadolint = require("efmls-configs.linters.hadolint")
	-- local solhint = require("efmls-configs.linters.solhint")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			-- "python",
			-- "json",
			-- "jsonc",
			-- "sh",
			-- "javascript",
			-- "javascriptreact",
      -- "ruby",
			-- "typescript",
			-- "typescriptreact",
			-- "svelte",
			-- "vue",
			-- "markdown",
			-- "docker",
			-- "solidity",
		},

		settings = {
			languages = {
				lua = { luacheck, stylua },
				-- python = { flake8, black },
				-- typescript = { eslint_d, prettierd },
				-- json = { eslint_d, fixjson },
				-- jsonc = { eslint_d, fixjson },
				-- sh = { shellcheck, shfmt },
				-- javascript = { eslint_d, prettierd },
				-- javascriptreact = { eslint_d, prettierd },
				-- typescriptreact = { eslint_d, prettierd },
				-- svelte = { eslint_d, prettierd },
				-- vue = { eslint_d, prettierd },
				-- markdown = { alex, prettierd },
				-- docker = { hadolint, prettierd },
				-- solidity = { solhint },
			},
		},
	})
end
]]
