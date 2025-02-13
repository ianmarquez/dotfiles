local M = {}

M.layouts = {
	input = {
		layout = {
			backdrop = true,
			width = 0.3,
			min_width = 50,
			height = 0.4,
			min_height = 2,
			box = "vertical",
			border = "rounded",
			title = "{title}",
			title_pos = "left",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
			{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
		},
	},
	explorer = {
		layout = {
			backdrop = false,
			width = 40,
			min_width = 40,
			height = 0,
			position = "right",
			border = "left",
			box = "vertical",
			{
				win = "input",
				height = 1,
				border = "bottom",
				title = " File Explorer {flags}",
				title_pos = "left",
			},
			{ win = "list", border = "none", title = " File Explorer {flags}", title_pos = "left" },
		},
	},
	vertical_reverse = {
		layout = {
			backdrop = true,
			width = 0.5,
			min_width = 80,
			height = 0.8,
			min_height = 30,
			box = "vertical",
			border = "rounded",
			title_pos = "center",
			title = "{title} {live} {flags}",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "preview", title = "{preview}", border = "bottom" },
			{ win = "list", border = "none", height = 0.3 },
		},
	},
	select_small = {
		layout = {
			backdrop = true,
			width = 0.4,
			min_width = 40,
			height = 0.4,
			min_height = 3,
			box = "vertical",
			border = "rounded",
			title = "{title}",
			title_pos = "left",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
	},
}

M.dashboard = {
	sections = {
		{ section = "header" },
		{ section = "keys", gap = 1, padding = 1 },
		{ icon = " ", title = "Projects", section = "projects", padding = 1, indent = 1 },
		{ section = "startup" },
	},
}

M.input = {
	position = "bottom",
	win = {
		style = {
			row = 15,
			title_pos = "left",
			backdrop = true,
		},
	},
}

M.keys = {
	{
		"<c-/>",
		function()
			require("snacks").terminal.toggle()
		end,
		desc = "Terminal",
	},
	{
		"<leader>tv",
		function()
			require("snacks").terminal.toggle("lazydocker")
		end,
		desc = "LazyDocker (Terminal)",
	},
	{
		"<leader>go",
		function()
			require("snacks").gitbrowse()
		end,
		desc = "[g]it [o]pen in browser (Git)",
	},
	{
		"<leader>tg",
		function()
			require("snacks").lazygit()
		end,
		desc = "Lazygit (Terminal)",
	},
	{
		"<leader>nd",
		function()
			require("snacks").notifier.hide()
		end,
		desc = "[n]otifications [d]ismiss (Notifications)",
	},
	{
		"<leader>nn",
		function()
			require("snacks").notifier.show_history()
		end,
		desc = "[n]otificatio[n]s show (Notifications)",
	},
	{
		"<leader>fq",
		function()
			require("snacks").picker.qflist({
				layout = M.layouts.vertical_reverse,
			})
		end,
		desc = "[f]ind in [q]uickfix list (Picker)",
	},
	{
		"<leader>fs",
		function()
			require("snacks").picker.grep({ hidden = true })
		end,
		desc = "[f]ind [s]tring (Picker)",
	},
	{
		"<leader>fc",
		function()
			require("snacks").picker.grep_buffers({})
		end,
		desc = "[f]ind in [c]urrent Buffer (Picker)",
	},
	{
		"<leader>bb",
		function()
			require("snacks").picker.buffers({
				layout = M.layouts.select_small,
				finder = "buffers",
				format = "buffer",
				hidden = false,
				current = true,
				sort_lastused = true,
				focus = "list",
				win = {
					input = { keys = { ["dd"] = "bufdelete" } },
					list = { keys = { ["dd"] = "bufdelete" } },
				},
			})
		end,
		desc = "find [b][b]uffers (Picker)",
	},
	{
		"<leader>ff",
		function()
			require("snacks").picker.files()
		end,
		desc = "[f]ind [f]iles (Picker)",
	},
	{
		"<leader>o",
		function()
			require("snacks").picker.lsp_symbols({ layout = M.layouts.vertical_reverse })
		end,
		desc = "Sh[o]w Symbols in Current File (Picker)",
	},
	{
		"<leader>fk",
		function()
			require("snacks").picker.keymaps({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[f]ind [k]eymaps (Picker)",
	},
	{
		"<leader>fh",
		function()
			require("snacks").picker.help({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[f]ind [h]elp documents (Picker)",
	},
	{
		"<leader>fi",
		function()
			require("snacks").picker.icons()
		end,
		desc = "[f]ind [i]cons (Picker)",
	},
	{
		"<leader>fg",
		function()
			require("snacks").picker.git_diff({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[f]ind [g]it diff (Picker)",
	},
	{
		"<leader>gf",
		function()
			require("snacks").picker.git_log_file({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[g]it current [f]ile History (Git)",
	},
	{
		"<leader>gl",
		function()
			require("snacks").picker.git_log({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[g]it [l]og current working directory (Git)",
	},
	{
		"<leader>gs",
		function()
			require("snacks").picker.git_status({
				layout = "vertical",
				win = {
					input = {
						keys = {
							["aa"] = { "git_stage", mode = { "n", "i" } },
						},
					},
				},
			})
		end,
		desc = "[g]it [s]tatus (Git)",
	},
	{
		"<leader>gg",
		function()
			require("snacks").picker.git_branches({
				layout = M.layouts.vertical_reverse,
				win = {
					input = {
						keys = {
							["aa"] = { "git_branch_add", mode = { "n", "i" } },
							["dd"] = { "git_branch_del", mode = { "n", "i" } },
						},
					},
				},
			})
		end,
		desc = "[g]it branches (Git)",
	},
	{
		"gf",
		function()
			require("snacks").picker.lsp_references({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[g]o LSP re[f]erences (Picker)",
	},
	{
		"gD",
		function()
			require("snacks").picker.lsp_type_definitions({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[g]o to type [D]efinitions (Picker)",
	},
	{
		"gd",
		function()
			require("snacks").picker.lsp_definitions({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[g]o [d]efinitions (Picker)",
	},
	{
		"<leader>fu",
		function()
			require("snacks").picker.undo({ layout = M.layouts.vertical_reverse })
		end,
		desc = "[f]ind [u]ndo",
	},
	{
		"<leader>e",
		function()
			require("snacks").explorer({ hidden = true })
		end,
		desc = "toggle [e]xplorer (Explorer)",
	},
}

M.picker = {
	icons = {
		ui = {
			live = "",
			hidden = "󰘓",
			ignored = "",
			selected = "󰱒 ",
			unselected = "󰄱 ",
		},
	},
	matcher = { frecency = true },
	win = {
		input = {
			keys = {
				["<Esc>"] = { "close", mode = { "n", "i" } },
				["J"] = { "preview_scroll_down", mode = { "n", "i" } },
				["K"] = { "preview_scroll_up", mode = { "n", "i" } },
				["H"] = { "preview_scroll_left", mode = { "n", "i" } },
				["L"] = { "preview_scroll_right", mode = { "n", "i" } },
			},
		},
	},
	sources = {
		select = {
			focus = "input",
			layout = { preview = false, layout = M.layouts.input },
		},
		files = {
			hidden = true,
			layout = M.layouts.vertical_reverse,
		},
		grep_buffers = { layout = M.layouts.vertical_reverse },
		grep = { layout = M.layouts.vertical_reverse },
		explorer = { jump = { close = true }, layout = M.layouts.explorer },
	},
}

M.config = {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		dashboard = M.dashboard,
		explorer = { replace_netrw = true },
		input = M.input,
		notifier = { timeout = 1500 },
		notify = {},
		picker = M.picker,
		quickfile = {},
		rename = {},
		scope = {},
		terminal = {
			win = {
				wo = { winbar = "" },
				border = "rounded",
			},
		},
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
	init = function()
		vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = "#89dceb" })
	end,
	keys = M.keys,
}

return M.config
