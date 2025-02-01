return {
	"Bekaboo/dropbar.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local dropbar_api = require("dropbar.api")
		vim.keymap.set("n", "<Leader>dn", dropbar_api.pick, { desc = "Pick symbols in winbar (Dropbar)" })
	end,
}
