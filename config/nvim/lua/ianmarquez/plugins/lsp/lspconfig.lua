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
		-- local util = require("lspconfig/util")

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
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
			end,
		})

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
			vim.lsp.config(lsp, {})
			vim.lsp.enable(lsp)
		end

		vim.lsp.config("ts_ls", {
			-- root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
			filetypes = { "typescript", "typescriptreact", "svelte" },
			cmd = { "typescript-language-server", "--stdio" },
			workspace_required = true,
			root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
		})
		vim.lsp.enable("ts_ls")

		-- configure svelte server
		vim.lsp.config("svelte", {
			-- root_dir = util.root_pattern("tsconfig.json", "package.json", ".git"),
			filetypes = { "svelte" },
		})
		vim.lsp.enable("svelte")

		-- configure graphql language server
		vim.lsp.config("graphql", {
			filetypes = {
				"graphql",
				"gql",
				"svelte",
				"typescriptreact",
				"javascriptreact",
			},
		})
		vim.lsp.enable("graphql")

		-- configure emmet language server
		vim.lsp.config("emmet_ls", {
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
		vim.lsp.enable("emmet_ls")

		vim.lsp.config("templ", {
			filetypes = {
				"templ",
			},
		})
		vim.lsp.enable("templ")

		-- configure gopls server
		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
			-- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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
		vim.lsp.enable("gopls")

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
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
		vim.lsp.enable("lua_ls")

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
