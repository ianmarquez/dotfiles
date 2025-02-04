return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame_opts = {
			delay = 400,
		},
	},
	keys = {
		{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle [g]it [b]lame" },
	},
}
