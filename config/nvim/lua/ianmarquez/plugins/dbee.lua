return {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "MattiasMTS/cmp-dbee",
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install()
	end,
	config = true,
	keys = {
		{ "<leader>db", "<cmd>Dbee toggle<cr>", desc = "Toggle DB (Database)" },
	},
}
