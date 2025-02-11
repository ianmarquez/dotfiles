local M = {
	buffers = {},
	buf_names = {},
}

function M:close_others()
	local current_buf = vim.api.nvim_get_current_buf()
	local buf_to_be_closed = {}
	local count = 0

	for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
		if bufnr ~= current_buf then
			if vim.api.nvim_get_option_value("modified", { buf = bufnr }) == false then
				count = count + 1
				table.insert(buf_to_be_closed, bufnr)
			end
		end
	end

	if count > 0 then
		vim.cmd({
			cmd = "bdelete",
			args = buf_to_be_closed,
		})
	end
end

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
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		tabline = {
			lualine_b = {
				{
					"buffers",
					-- buffers_color = {
					-- 	active = { bg = "#313244", fg = "#cdd6f4", gui = "bold" },
					-- 	inactive = { bg = "#181825", fg = "#6c7086", gui = "italic" },
					-- },
					use_mode_colors = true,
					symbols = { newFile = "", modified = " ", readonly = " " },
				},
			},
		},
		sections = {
			lualine_a = {
				{ "fancy_mode", width = 3 },
			},
			lualine_b = {
				{ "fancy_branch" },
				{ "fancy_diff" },
			},
			lualine_c = {
				{ "fancy_cwd", substitute_home = true },
			},
			lualine_x = {
				{ "fancy_macro" },
				{ "fancy_diagnostics" },
				{ "fancy_searchcount" },
				{ "fancy_location" },
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#FFB86C" },
				},
			},
			lualine_y = {
				{ "fancy_filetype", ts_icon = "" },
			},
			lualine_z = { "fancy_lsp_servers" },
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
				M:close_others()
			end,
			desc = "Close all buffers except current (Tabs)",
			mode = "n",
		},
		{
			"<leader>bx",
			function()
				M:process_by_ordinal("bdelete", " Close buffer:")
			end,
			desc = "Close buffer (Tabs)",
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
