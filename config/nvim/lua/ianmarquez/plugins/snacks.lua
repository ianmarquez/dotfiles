local M = {}

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
		"<leader>gb",
		function()
			require("snacks").git.blame_line()
		end,
		desc = "Git Blame Line",
	},
	{
		"<leader>gB",
		function()
			require("snacks").gitbrowse()
		end,
		desc = "Git Browse",
	},
	{
		"<leader>tg",
		function()
			require("snacks").lazygit()
		end,
		desc = "Lazygit (Terminal)",
	},
	{
		"<leader>gf",
		function()
			require("snacks").lazygit.log_file()
		end,
		desc = "Lazygit Current File History (Terminal)",
	},
	{
		"<leader>gl",
		function()
			require("snacks").lazygit.log()
		end,
		desc = "Lazygit Log (cwd) (Terminal)",
	},
	{
		"<leader>nd",
		function()
			require("snacks").notifier.hide()
		end,
		desc = "[N]otifications [D]ismiss (Notifications)",
	},
	{
		"<leader>nn",
		function()
			require("snacks").notifier.show_history()
		end,
		desc = "[N]otificatio[n]s show (Notifications)",
	},

	{
		"<leader>fq",
		function()
			require("snacks").picker.quickfix()
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
			require("snacks").picker.grep_buffers()
		end,
		desc = "[f]ind in [c]urrent Buffer (Picker)",
	},
	{
		"<leader>fb",
		function()
			require("snacks").picker.buffers()
		end,
		desc = "[f]ind [b]uffers (Picker)",
	},
	{
		"<leader>ff",
		function()
			require("snacks").picker.files({ hidden = true })
		end,
		desc = "[f]ind [f]iles (Picker)",
	},
	{
		"<leader>o",
		function()
			require("snacks").picker.lsp_symbols()
		end,
		desc = "Sh[o]w Symbols in Current File (Picker)",
	},
	{
		"<leader>fk",
		function()
			require("snacks").picker.keymaps()
		end,
		desc = "[f]ind [k]eymaps (Picker)",
	},
	{
		"<leader>fh",
		function()
			require("snacks").picker.help()
		end,
		desc = "[f]ind [h]elp documents (Picker)",
	},
	{
		"gf",
		function()
			require("snacks").picker.lsp_references()
		end,
		desc = "[g]o LSP re[f]erences (Picker)",
	},
	{
		"gD",
		function()
			require("snacks").picker.lsp_type_definitions()
		end,
		desc = "[g]o to type [D]efinitions (Picker)",
	},
	{
		"gd",
		function()
			require("snacks").picker.lsp_definitions()
		end,
		desc = "[g]o [d]efinitions (Picker)",
	},
	{
		"<leader>fu",
		function()
			require("snacks").picker.undo()
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
	sources = {
		select = {
			focus = "list",
			layout = {
				preview = false,
				layout = {
					backdrop = true,
					width = 0.3,
					min_width = 50,
					height = 0.4,
					min_height = 3,
					box = "vertical",
					border = "rounded",
					title = "{title}",
					title_pos = "left",
					{ win = "input", height = 1, border = "bottom" },
					{ win = "list", border = "none" },
					{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
				},
			},
		},
		explorer = {
			jump = { close = true },
			layout = {
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
						border = "rounded",
						title = " File Explorer {flags}",
						title_pos = "left",
					},
					{ win = "list", border = "none", title = " File Explorer {flags}", title_pos = "left" },
				},
			},
		},
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
