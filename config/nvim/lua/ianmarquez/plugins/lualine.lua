return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		-- "nvim-tree/nvim-web-devicons",
		"echasnovski/mini.icons",
		"meuter/lualine-so-fancy.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	lazy = true,
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 0,
					symbols = {
						newFile = "",
						modified = " ",
						readonly = " ",
					},
				},
			},
			lualine_x = {
				{ "fancy_macro" },
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#FFB86C" },
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		},
	},
}
