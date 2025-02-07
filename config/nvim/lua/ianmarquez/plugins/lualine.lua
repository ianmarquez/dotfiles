local M = {
	buffers = {},
	buf_names = {},
}

function M:build_buffer_name_table()
	self.buf_names = {}
	self.buffers = {}
	for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
		local condition = vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
		if condition == true then
			local bufName = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
			self.buffers[bufName] = bufnr
			table.insert(self.buf_names, bufName)
		end
	end
end

function M:process_by_ordinal(buffCmd, prompt)
	self.build_buffer_name_table(self)

	vim.ui.select(self.buf_names, {
		prompt = prompt,
		main = { current = true },
	}, function(choice)
		if choice ~= nil then
			local cmd = buffCmd .. self.buffers[choice]
			vim.cmd(cmd)
		end
	end)
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"meuter/lualine-so-fancy.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	lazy = true,
	opts = {
		options = {
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		tabline = {
			lualine_b = {
				{
					"buffers",
					symbols = {
						newFile = "",
						modified = " ",
						readonly = " ",
					},
				},
			},
			lualine_z = {
				{ "fancy_macro" },
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#FFB86C" },
				},
			},
		},
		sections = {
			lualine_b = {
				{
					"filename",
					symbols = {
						newFile = "",
						modified = " ",
						readonly = " ",
					},
				},
			},
			lualine_c = {},
			lualine_x = {
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		},
	},
	keys = {
		{
			"<S-h>",
			function()
				vim.cmd([[bprev]])
			end,
			desc = "Previous buffer (Tabs)",
			mode = "n",
		},
		{
			"<S-l>",
			function()
				vim.cmd([[bnext]])
			end,
			desc = "Next buffer (Tabs)",
			mode = "n",
		},
		{
			"<leader>bc",
			function()
				vim.cmd([[%bd|e#|bd#]])
			end,
			desc = "Close all buffers except current (Tabs)",
			mode = "n",
		},
		{
			"<leader>bx",
			function()
				M:process_by_ordinal("bdelete", " Close buffer:")
			end,
			desc = "Close all buffers except current (Tabs)",
			mode = "n",
		},
		{
			"<leader>bb",
			function()
				M:process_by_ordinal("b", " Go to buffer:")
			end,
			desc = "Go to buffer (Tabs)",
			mode = "n",
		},
	},
}
