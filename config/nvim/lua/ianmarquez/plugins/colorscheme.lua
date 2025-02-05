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
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
					nvimtree = true,
					noice = true,
					notify = true,
					symbols_outline = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
}
