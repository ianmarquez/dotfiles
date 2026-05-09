return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-context",
	},
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	-- commit = "364b86e",
	config = function()
		require("treesitter-context").setup({
			max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
			trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		})
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
		})
		local treesitter = require("nvim-treesitter")

		treesitter.setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"graphql",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
				"templ",
				"tsx",
				"typescript",
				"vim",
				"vue",
				"yaml",
				"zig",
			},
			-- auto install above language parsers
			auto_install = true,
		})
	end,
}
