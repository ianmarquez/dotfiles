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

-- Autocommand to toggle relative line numbers based on mode
vim.api.nvim_create_augroup("ToggleRelativeLineNumbers", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	group = "ToggleRelativeLineNumbers",
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	group = "ToggleRelativeLineNumbers",
	callback = function()
		vim.opt.relativenumber = true
	end,
})
