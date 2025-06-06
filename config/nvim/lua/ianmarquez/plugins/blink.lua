local M = {}

M.default_binds = {
	preset = "default",
	["<Up>"] = { "insert_prev", "fallback" },
	["<Down>"] = { "insert_next", "fallback" },
	["<C-k>"] = { "insert_prev", "fallback" },
	["<C-j>"] = { "insert_next", "fallback" },
	["<S-CR>"] = { "select_and_accept", "fallback" },
}

M.combine = function(second_table, first_table)
	local merge = {}
	for k, v in pairs(first_table) do
		merge[k] = v
	end
	for k, v in pairs(second_table) do
		merge[k] = v
	end
	return merge
end

M.config = {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {
			enable_events = true,
		},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
		},
		lazy = true,
		event = "InsertEnter",
		version = "*",
		opts = {
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				-- providers = {
				--   dbee = {
				--     name = "cmp-dbee",
				--     module = 'blink.compat.source',
				--     score_offset = 1,
				--   }
				-- }
			},
			completion = {
				menu = {
					border = "single",
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					window = { border = "single" },
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				accept = {
					auto_brackets = { enabled = true },
				},
				ghost_text = {
					enabled = vim.g.ai_cmp,
				},
			},
			keymap = M.combine(M.default_binds, {
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
			}),
			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
				keymap = {
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
					["<C-y>"] = { "select_and_accept", "fallback" },
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
		},
	},
}

return M.config
