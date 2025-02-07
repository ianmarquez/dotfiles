return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"antosha417/nvim-lsp-file-operations",
			config = true,
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")

		local keymap = vim.keymap

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			float = {
				border = "rounded",
				header = false,
				focusable = true,
			},
		})

		local opts = { noremap = true, silent = true }
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			opts.desc = "View [c]ode [a]ctions"
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "LSP [r]e[n]ame"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "[r]e[s]tart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			opts.desc = "Typescript [o]rganize [i]mports"
			keymap.set("n", "<leader>oi", ":OrganizeImports<CR>", opts) -- mapping to organize imports for typescript

			opts.desc = "Show diagnostic floating window"
			keymap.set("n", "<leader>dk", vim.diagnostic.open_float, opts) -- show diagnostic floating window
		end

		-- used to enable autocompletion (assign to every lsp server config)

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
				title = "",
			}
			vim.lsp.buf.execute_command(params)
		end

		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			commands = {
				OrganizeImports = {
					organize_imports,
					description = "Organize Imports",
				},
			},
		})

		local servers = {
			"gleam",
			"html",
			"cssls",
			"tailwindcss",
			"prismals",
			"pyright",
			"cmake",
			"templ",
		}

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
			})
		end

		lspconfig["omnisharp"].setup({
			on_attach = on_attach,
			-- root_dir = function(fname)
			--   local primary = lspconfig.util.root_pattern("*.sln")(fname)
			--   local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
			--   return primary or fallback
			-- end,
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
		})

		-- configure svelte server
		lspconfig["svelte"].setup({
			on_attach = on_attach,
			filetypes = { "svelte" },
		})

		-- configure graphql language server
		lspconfig["graphql"].setup({
			on_attach = on_attach,
			filetypes = {
				"graphql",
				"gql",
				"svelte",
				"typescriptreact",
				"javascriptreact",
			},
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			on_attach = on_attach,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
				"templ",
			},
		})

		-- configure gopls server
		lspconfig["gopls"].setup({
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					-- usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		vim.filetype.add({
			extension = {
				mdx = "jsx",
				postcss = "css",
				sass = "css",
				less = "css",
				keymap = "c",
				overlay = "c",
				conf = "sh",
			},
			pattern = {
				[".env.*"] = "sh",
			},
		})
	end,
}
