if true then
	return {}
end
return {
	"yetone/avante.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "Avante" } },
			ft = { "markdown", "Avante" },
		},
	},
	config = function(_, opts)
		require("mini.icons").setup()
		require("mini.icons").mock_nvim_web_devicons()
		require("avante").setup(opts)
	end,
	event = { "BufReadPre", "BufNewFile" },
	build = "make",
	opts = { provider = "copilot" },
}
