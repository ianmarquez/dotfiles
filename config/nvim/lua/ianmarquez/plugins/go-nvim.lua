return {
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
			":GoAddTag<CR>",
			desc = "Add go struct tags (Go)",
			mode = { "n" },
		},
		{
			"<leader>gtr",
			":GoRmTag<CR>",
			desc = "Remove go struct tags (Go)",
			mode = { "n" },
		},
	},
}
