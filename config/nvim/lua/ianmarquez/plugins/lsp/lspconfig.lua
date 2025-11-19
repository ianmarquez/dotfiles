local on_attach = function()
	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap

	opts.desc = "View [c]ode [a]ctions"
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "LSP [r]e[n]ame"
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

	opts.desc = "[r]e[s]tart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts) -- jump to previous diagnostic in buffer

	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts) -- jump to next diagnostic in buffer
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
		local servers = {
			"cmake",
			"cssls",
			"emmet_ls",
			"gleam",
			"graphql",
			"html",
			"prismals",
			"pyright",
			"svelte",
			"tailwindcss",
			"templ",
		}

		for _, lsp in ipairs(servers) do
			vim.lsp.config(lsp, { on_attach = on_attach })
			vim.lsp.enable(lsp)
		end

		vim.lsp.config("ts_ls", {
			workspace_required = true,
			on_attach = function(client, bufnr)
				on_attach()
				vim.keymap.set("n", "<leader>oi", function()
					if client ~= nil then
						return client:exec_cmd({
							title = "TS Organize Imports",
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(bufnr) },
						})
					end
				end, { noremap = true, silent = true, desc = "Typescript [o]rganize [i]mports" }) -- mapping to organize imports for typescript
			end,
		})
		vim.lsp.enable("ts_ls")

		-- configure gopls server
		vim.lsp.config("gopls", {
			cmd = { "gopls" },
			on_attach = on_attach,
			filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
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
		vim.lsp.enable("go_pls")

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.filetype.add({
			extension = {
				mdx = "jsx",
				mjs = "javascript",
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
