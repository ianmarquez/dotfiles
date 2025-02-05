local M = {}

M.is_open = false

M.toggle_qf = function()
	if M.is_open == true then
		vim.cmd([[cclose]])
	else
		vim.cmd([[copen]])
	end
	M.is_open = not M.is_open
end

M.config = {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	keys = {
		{
			"<leader>q",
			M.toggle_qf,
			desc = "Toggle [q]uickfix list (BQF)",
			mode = { "n", "v" },
		},
	},
}

return M.config
