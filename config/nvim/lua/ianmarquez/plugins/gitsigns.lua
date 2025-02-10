return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame_opts = {
			delay = 400,
		},
	},
	keys = {
		{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle [g]it [b]lame (Git)" },
		{ "<leader>gh", "<cmd>Gitsigns stage_hunk<cr>", desc = "[g]it stage [h]unk (Git)", mode = "n" },
		{
			"<leader>gh",
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "[g]it stage [h]unk (Git)",
			mode = "v",
		},
		{ "<leader>gH", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "[g]it undo stage [H]unk (Git)", mode = "n" },
		{
			"<leader>gH",
			function()
				require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "[g]it undo stage [H]unk (Git)",
			mode = "v",
		},
		{
			"<leader>gr",
			function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			desc = "[g]it [r]eset hunk (Git)",
			mode = "v",
		},
		{ "<leader>gB", "<cmd>Gitsigns stage_buffer<cr>", desc = "[g]it stage [b]uffer (Git)" },
		{
			"<leader>gd",
			function()
				require("gitsigns").diffthis()
			end,
			desc = "[g]it [d]iff (Git)",
		},
		{
			"<leader>g[",
			function()
				require("gitsigns").nav_hunk("prev")
			end,
			desc = "[g]it ([)prev hunk (Git)",
		},
		{
			"<leader>g]",
			function()
				require("gitsigns").nav_hunk("next")
			end,
			desc = "[g]it (])next hunk (Git)",
		},
	},
}
