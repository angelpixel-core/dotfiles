local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local lspconfig = require("lspconfig")

	-- Editor Signs
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
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
		capabilities = capabilities,
		on_attach = on_attach,
		autoformat = true,
	})

	-- Python
	lspconfig.pyright.setup({
		capabilities = capabilities,
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

	-- TypeScript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")

	-- HTML, TSX, JSX, CSS, SASS, SCSS, Vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"vue",
		},
		init_options = {
			html = {
				options = {
					-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
					["bem.enabled"] = true,
				},
			},
		},
	})

	-- JSON
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})
	local fixjson = require("efmls-configs.formatters.fixjson")

	-- Bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	-- Markdown
	local alex = require("efmls-configs.linters.alex")

	-- Docker
	local hadolint = require("efmls-configs.linters.hadolint")

	-- Configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"typescript",
			"javascript",
			"css",
			"sass",
			"scss",
			"html",
			"vue",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"markdown",
			"docker",
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
				typescritp = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				markdown = { alex, prettier_d },
				docker = { hadolint, prettier_d },
			},
		},
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
  local config = function()
  -- Solidity
  lspconfig.solidity.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "solidity" },
  })
  local solhint = require("efmls-configs.linters.solhint")

  lspconfig.efm.setup({
    filetypes = {
      "sol",
    },
    settings = {
      languages = {
        solidity = { solhint },
      },
    },
  })
  end
--]]
