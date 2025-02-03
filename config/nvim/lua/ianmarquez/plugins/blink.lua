local P = {}

P.default_binds = {
	preset = "default",
	["<Up>"] = { "select_prev", "fallback" },
	["<Down>"] = { "select_next", "fallback" },
	["<C-k>"] = { "select_prev", "fallback" },
	["<C-j>"] = { "select_next", "fallback" },
	["<Tab>"] = { "accept", "fallback" },
}

P.combine = function(second_table, first_table)
	local merge = {}
	for k, v in pairs(first_table) do
		merge[k] = v
	end
	for k, v in pairs(second_table) do
		merge[k] = v
	end
	return merge
end

P.config = {
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
		event = "VeryLazy",
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
				menu = { border = "single" },
				documentation = {
					window = { border = "single" },
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			keymap = P.combine(P.default_binds, {
				["<S-k>"] = { "scroll_documentation_up", "fallback" },
				["<S-j>"] = { "scroll_documentation_down", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				cmdline = P.default_binds,
			}),
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
		},
	},
}

return P.config
