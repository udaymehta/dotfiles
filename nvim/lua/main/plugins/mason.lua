return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = true,
			underline = true,
			severity_sort = false,
			float = true,
		})

		local on_attach = function(bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		end
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"basedpyright",
				"ruff",
				"ts_ls",
				"tailwindcss",
				"lua_ls",
				"clangd",
				"rust_analyzer",
			},

			automatic_installation = true,
			handlers = {
				function(server_name)
					local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = lsp_capabilities,
						on_attach = on_attach,
					})
				end,
				lua_ls = function()
					local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig").lua_ls.setup({
						capabilities = lsp_capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
				basedpyright = function()
					local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig").basedpyright.setup({
						capabilities = lsp_capabilities,
						on_attach = on_attach,
						settings = {
							basedpyright = {
								analysis = {
									diagnosticsMode = "openFilesOnly",
									autoImportCompletions = true,
								},
								disableOrganizeImports = true,
							},
						},
					})
				end,
				ruff = function()
					local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig").ruff.setup({
						capabilities = lsp_capabilities,
						on_attach = on_attach,
						init_options = {
							settings = {
								organizeImports = true,
								showSyntaxErrors = true,
								lint = {
									ignore = {
										"E501",
										"F401",
									},
								},
								logLevel = "debug",
								args = {},
							},
						},
					})
				end,
			},
		})
	end,
}
