local group = vim.api.nvim_create_augroup("Custom Au Group", { clear = true })

-- vim.api.nvim_create_autocmd("InsertLeave", {
--   command = ":update",
--   group = group,
--   desc = "Save on InsertLeave"
-- })

vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		if vim.fn.argc(-1) > 0 then
			require("snacks").explorer.open()
		end
	end,
	group = group,
	once = true,
	desc = "Close Explorer on load",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.md" },
	group = group,
	callback = function()
		vim.opt_local.wrap = true
	end,
})

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

vim.api.nvim_create_user_command("LspRestartAll", function()
	vim.lsp.stop_client(vim.lsp.get_active_clients(), true)
	vim.cmd("edit")
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { noremap = true, silent = true }
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local keymap = vim.keymap

		setUpDiagnostics()

		opts.desc = "View [c]ode [a]ctions"
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "LSP [r]e[n]ame"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "[r]e[s]tart LSP"
		keymap.set("n", "<leader>rs", ":LspRestartAll<CR>", opts) -- mapping to restart lsp if necessary

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

		-- Example: echo the client name
		-- print("LSP attached:", client.name)

		-- Optional: Setup signature help, formatting, etc.
	end,
})
