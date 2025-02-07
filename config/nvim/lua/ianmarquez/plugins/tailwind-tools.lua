return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	event = {
		"BufReadPre *.templ",
		"BufNewFile *.templ",
		"CmdlineEnter *.templ",
		"BufReadPre *.html",
		"BufNewFile *.html",
		"CmdlineEnter *.html",
		"BufReadPre *.tsx",
		"BufNewFile *.tsx",
		"CmdlineEnter *.tsx",
		"BufReadPre *.jsx",
		"BufNewFile *.jsx",
		"CmdlineEnter *.jsx",
		"BufReadPre *.svelte",
		"BufNewFile *.svelte",
		"CmdlineEnter *.svelte",
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		server = { override = false },
		cmp = { highlight = "background" },
		conceal = {
			enabled = true,
			symbol = "",
		},
	}, -- your configuration
	keys = {
		{
			"<leader>twc",
			function()
				vim.cmd([[TailwindConcealToggle]])
			end,
			desc = "Toggle [t]ail[w]ind [c]onceal (Tailwind Tools)",
			mode = "n",
		},
		{
			"<leader>tws",
			function()
				vim.cmd([[TailwindSort]])
			end,
			desc = "[t]ail[w]ind [s]sort classes (Tailwind Tools)",
			mode = "n",
		},
		{
			"<leader>tws",
			":TailwindSortSelectionSync<CR>",
			desc = "[t]ail[w]ind [s]sort selected classes (Tailwind Tools)",
			mode = "v",
		},
	},
}
