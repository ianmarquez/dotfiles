local M = {}

M.config = {
	{ "echasnovski/mini.move", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.bufremove", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.splitjoin", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.pairs", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.icons", version = "*", opts = { style = "glyph" }, lazy = true },
	{
		"echasnovski/mini.comment",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				comment_visual = "gc",
				textobject = "gc",
			},
		},
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
					hack = { pattern = "HACK", group = "MiniHipatternsHack" },
					todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
					note = { pattern = "NOTE", group = "MiniHipatternsNote" },
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add [S]urrounding (Surround)", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "[D]elete [S]urrounding (Surround)" },
				{ opts.mappings.find, desc = "[F]ind Right [S]urrounding (Surround)" },
				{ opts.mappings.find_left, desc = "Find Left [S]urrounding (Surround)" },
				{ opts.mappings.highlight, desc = "Highlight Surrounding (Surround)" },
				{ opts.mappings.replace, desc = "[C]hange [S]urrounding (Surround)" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines` (Surround)" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "S", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "fs", -- Find surrounding (to the right)
				find_left = "Fs", -- Find surrounding (to the left)
				highlight = "", -- Highlight surrounding
				replace = "cs", -- Replace surrounding
				update_n_lines = "", -- Update `n_lines`
			},
		},
	},
}

return M.config
