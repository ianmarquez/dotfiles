return {
	{
		"fredrikaverpil/godoc.nvim",
		version = "*",
		dependencies = {
			{ "folke/snacks.nvim" }, -- optional
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "go" },
				},
			},
		},
		event = { "BufReadPre *.go", "BufNewFile *.go", "CmdlineEnter *.go" },
		ft = { "go", "gomod" },
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
		cmd = { "GoDoc" }, -- optional
		opts = {
			picker = {
				type = "snacks",
				snacks = {
					layout = "vertical",
				},
			},
		},
		keys = {
			{
				"<leader>gtd",
				function()
					vim.cmd([[GoDoc]])
				end,
				desc = "View go documentation",
				mode = { "n" },
			},
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		event = { "BufReadPre *.go", "BufNewFile *.go", "CmdlineEnter *.go" },
		ft = { "go", "gomod" },
		opts = {},
		keys = {
			{
				"<leader>gta",
				function()
					vim.cmd([[GoAddTag]])
				end,
				desc = "Add go struct tags (Go)",
				mode = { "n" },
			},
			{
				"<leader>gtr",
				function()
					vim.cmd([[GoRmTag]])
				end,
				desc = "Remove go struct tags (Go)",
				mode = { "n" },
			},
		},
	},
}
