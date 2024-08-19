return {
	"voldikss/vim-floaterm",
	lazy = true,
	keys = {
		{ "<F1>", ":FloatermToggle<cr>", desc = "Toggle Floaterm" },
		{ "<leader>tn", ":FloatermNew<cr>", desc = "New Floaterm" },
		{ "<leader>tg", ":FloatermNew lazygit<cr>", desc = "Open lazygit" },
	},
	init = function()
		vim.g.floaterm_keymap_toggle = "<F1>"
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8
		vim.g.floatterm_wintitle = 1
		vim.g.floaterm_autoclose = 1
	end,
	-- config = function()
	-- 	local opts = { noremap = true, silent = true }
	-- 	local keymap = vim.keymap
	--
	-- 	opts.desc = "Toggle Floaterm"
	-- 	keymap.set("n", "<F1>", ":FloatermToggle<cr>", opts)
	--
	-- 	opts.desc = "New Floaterm"
	-- 	keymap.set("n", "<leader>tn", ":FloatermNew<cr>", opts)
	--
	-- 	opts.desc = "Open lazygit"
	-- 	keymap.set("n", "<leader>tg", ":FloatermNew lazygit<cr>", opts)
	-- end,
}
