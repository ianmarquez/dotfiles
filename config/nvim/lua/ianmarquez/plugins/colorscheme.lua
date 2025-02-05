return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "UiEnter",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					mason = true,
					native_lsp = { enabled = true },
					nvimtree = true,
					symbols_outline = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
}
