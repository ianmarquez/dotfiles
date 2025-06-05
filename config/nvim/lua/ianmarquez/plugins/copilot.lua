return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = true },
	},
	keys = {
		{
			"<leader>ct",
			function()
				vim.cmd([[Copilot toggle]])
			end,
			desc = "[C]opilot [t]oggle",
			mode = "n",
		},
	},
}
