return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		dashboard = {
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1 },
				{ icon = " ", title = "Projects", section = "projects", padding = { 2, 1 } },
				{ section = "startup" },
			},
		},
		explorer = {
			replace_netrw = true,
		},
		input = { position = "bottom", win = { style = { row = 10 } } },
		notifier = { timeout = 1500 },
		notify = {},
		picker = {
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
		},
		quickfile = {},
		rename = {},
		scope = {},
		terminal = {
			win = {
				wo = { winbar = "" },
				border = "rounded",
				-- position = "float",
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
	keys = {
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
			"<leader>fs",
			function()
				require("snacks").picker.grep({ hidden = true })
			end,
			desc = "[F]ind [S]tring (Picker)",
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.grep_buffers()
			end,
			desc = "[F]ind in [C]urrent Buffer (Picker)",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "[F]ind [B]uffers (Picker)",
		},
		{
			"<leader>ff",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "[F]ind [F]iles (Picker)",
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
			desc = "[F]ind [K]eymaps (Picker)",
		},
		{
			"<leader>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "[F]ind [H]elp documents (Picker)",
		},
		{
			"gf",
			function()
				require("snacks").picker.lsp_references()
			end,
			desc = "[G]o LSP re[f]erences (Picker)",
		},
		{
			"gD",
			function()
				require("snacks").picker.lsp_type_definitions()
			end,
			desc = "[G]o Type [D]efinitions (Picker)",
		},
		{
			"gd",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "[G]o [d]efinitions (Picker)",
		},
		{
			"<leader>fu",
			function()
				require("snacks").picker.undo()
			end,
			desc = "[F]ind [U]ndo",
		},
		{
			"<leader>e",
			function()
				require("snacks").explorer({ hidden = true })
			end,
			desc = "Toggle [e]xplorer (Explorer)",
		},
	},
}
