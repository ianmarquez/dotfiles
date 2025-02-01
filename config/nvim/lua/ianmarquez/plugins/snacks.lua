return {
	"folke/snacks.nvim",
	priority = 1000,
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
		input = { position = "bottom" },
		notifier = { timeout = 1500 },
		notify = {},
		picker = {
			sources = {
				explorer = {
					jump = { close = true },
					focus = "input",
					layout = {
						layout = {
							backdrop = true,
							width = 40,
							min_width = 40,
							height = 0,
							position = "right",
							border = "none",
							box = "vertical",
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = " File Explorer {flags}",
								title_pos = "left",
							},
							{ win = "list", border = "none" },
						},
					},
				},
			},
		},
		quickfile = {},
		rename = {},
		scope = {},
		terminal = {
			win = { wo = { winbar = "" } },
		},
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	},
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
			desc = "Dismiss Notifications (Notifications)",
		},
		{
			"<leader>nn",
			function()
				require("snacks").notifier.show_history()
			end,
			desc = "Show Notifications (Notifications)",
		},

		{
			"<leader>fs",
			function()
				require("snacks").picker.grep({ hidden = true })
			end,
			desc = "Live Grep",
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.grep_buffers()
			end,
			desc = "Live Grep Current Buffer",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>ff",
			function()
				require("snacks").picker.files({ hidden = true })
			end,
			desc = "Files",
		},
		{
			"<leader>o",
			function()
				require("snacks").picker.lsp_symbols()
			end,
			desc = "Symbols in Current File",
		},
		{
			"<leader>fk",
			function()
				require("snacks").picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Help",
		},
		{
			"gf",
			function()
				require("snacks").picker.lsp_references()
			end,
			desc = "Show LSP references",
		},
		{
			"gD",
			function()
				require("snacks").picker.lsp_type_definitions()
			end,
			desc = "Show Type Definitions",
		},
		{
			"gd",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "Show Definitions",
		},
		{
			"<leader>e",
			function()
				require("snacks").explorer({ hidden = true })
			end,
		},
	},
}
