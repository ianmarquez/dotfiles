return {
	"Bekaboo/dropbar.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	keys = {
		{
			"<leader>dn",
			function()
				require("dropbar.api").pick()
			end,
			desc = "Pick symbols in winbar (Dropbar)",
			mode = { "n" },
		},
	},
}
