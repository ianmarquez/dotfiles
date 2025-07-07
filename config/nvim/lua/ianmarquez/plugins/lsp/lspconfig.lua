local setUpDiagnostics = function()
	vim.diagnostic.config({
		virtual_text = true,
		virtual_lines = false,
		signs = true,
	})

	-- Change the Diagnostic symbols in the sign column (gutter)
	local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

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

		local function on_attach(client, bufnr)
			local opts = { noremap = true, silent = true }
			local keymap = vim.keymap

			setUpDiagnostics()

			opts.desc = "View [c]ode [a]ctions"
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "LSP [r]e[n]ame"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "[r]e[s]tart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			opts.desc = "Typescript [o]rganize [i]mports"
			keymap.set("n", "<leader>oi", function()
				if client ~= nil then
					return client:exec_cmd({
						title = "TS Organize Imports",
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(bufnr) },
					})
				end
			end, opts) -- mapping to organize imports for typescript

			opts.desc = "Toggle diagnostic lines"
			keymap.set("n", "<leader>dk", function()
				vim.diagnostic.config({
					virtual_lines = not vim.diagnostic.config().virtual_lines,
					virtual_text = not vim.diagnostic.config().virtual_text,
				})
			end, opts) -- show diagnostic floating window

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts) -- jump to next diagnostic in buffer
		end

		local servers = {
			"gleam",
			"html",
			"cssls",
			"tailwindcss",
			"prismals",
			"pyright",
			"cmake",
		}

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
			})
		end

		-- lspconfig["omnisharp"].setup({
		-- 	-- root_dir = function(fname)
		-- 	--   local primary = lspconfig.util.root_pattern("*.sln")(fname)
		-- 	--   local fallback = lspconfig.util.root_pattern("*.csproj")(fname)
		-- 	--   return primary or fallback
		-- 	-- end,
		-- 	cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
		-- })

		lspconfig["ts_ls"].setup({
			root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact", "svelte" },
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
			root_dir = util.root_pattern("tsconfig.json", "package.json", ".git", "go.work", "go.mod", ".git"),
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"vue",
				"solid",
				"svelte",
				"templ",
			},
		})

		lspconfig["templ"].setup({
			on_attach = on_attach,
			root_dir = util.root_pattern(".git", "go.work", "go.mod", ".git"),
			filetypes = {
				"templ",
			},
		})

		-- configure gopls server
		lspconfig["gopls"].setup({
			cmd = { "gopls" },
			on_attach = on_attach,
			filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					usePlaceholders = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-node_modules" },
					-- THIS is the important part:
					experimental = {
						fileExtensions = { "go", "templ" },
					},
					completeUnimported = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
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
