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
			for _, existing_client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
				if existing_client.name == client.name and existing_client.id ~= client.id then
					vim.lsp.stop_client(client.id)
					return
				end
			end

			-- Normal on_attach setup here
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
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
