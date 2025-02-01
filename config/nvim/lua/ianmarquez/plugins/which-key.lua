return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "helix",
		})

		wk.add({
			{
				"<leader>f",
				group = "Pickers",
			},
			{
				"<leader>w",
				group = "Window Control",
			},
			{
				"<leader>d",
				group = "DiffView/Diagnostics",
			},
			{
				"<leader>m",
				group = "Format",
			},
			{
				"<leader>t",
				group = "Tab/Trouble Control/Terminal",
			},
		})
	end,
}
