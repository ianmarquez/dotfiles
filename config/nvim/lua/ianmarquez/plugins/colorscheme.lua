return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "UiEnter",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					gitsigns = true,
					mason = true,
					native_lsp = { enabled = true },
					nvimtree = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					symbols_outline = true,
					bufferline = false,
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
}
