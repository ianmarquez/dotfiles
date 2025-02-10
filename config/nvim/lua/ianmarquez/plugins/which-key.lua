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
				group = "  Find",
			},
			{
				"<C-w>",
				group = "  Window Control",
			},
			{
				"<leader>w",
				group = "  Window Control",
			},
			{
				"<leader>n",
				group = "  Notification",
			},
			{
				"<leader>d",
				group = "  Diagnostics |  Dropbar",
			},
			{
				"<leader>m",
				group = "  Format",
			},
			{
				"<leader>t",
				group = "  Terminal",
			},
			{
				"<leader>b",
				group = "  Buffers",
			},
			{
				"<leader>tw",
				group = " 󱏿 Tailwind",
			},
			{
				"<leader>g",
				group = "  Git",
			},
		})
	end,
}
