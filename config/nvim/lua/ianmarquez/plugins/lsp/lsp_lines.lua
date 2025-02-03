return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lsp_lines").setup({})
		vim.diagnostic.config({ virtual_lines = false })
	end,
	keys = {
		{
			"<leader>dl",
			function()
				vim.diagnostic.config({
					virtual_lines = not vim.diagnostic.config().virtual_lines,
					virtual_text = not vim.diagnostic.config().virtual_text,
				})
			end,
			desc = "Show [d]iagnostic [l]ines",
			mode = "n",
		},
	},
}
