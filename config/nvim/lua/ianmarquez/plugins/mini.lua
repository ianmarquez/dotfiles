local P = {}

P.tabline = {
	instance = nil,
	buffers = {},
	buf_names = {},

	format = function(buf_id, label, showOrdinal)
		local suffix = vim.bo[buf_id].modified and "" or ""
		local readonly = vim.bo[buf_id].modifiable and "" or ""
		local ordinal = showOrdinal and "[" .. buf_id .. "]" or ""
		local title = readonly .. ordinal .. P.tabline.instance.default_format(buf_id, label) .. suffix
		return title
	end,

	build_buffer_name_table = function()
		P.tabline.buf_names = {}
		P.tabline.buffers = {}
		for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
			local condition = vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
			if condition == true then
				local bufName =
					P.tabline.format(bufnr, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"), true)
				P.tabline.buffers[bufName] = bufnr
				table.insert(P.tabline.buf_names, bufName)
			end
		end
	end,

	process_by_ordinal = function(buffCmd, prompt, opts)
		P.tabline.build_buffer_name_table()

		opts.format = function(buf_id, label)
			return P.tabline.format(buf_id, label, true)
		end

		P.tabline.instance.setup(opts)

		vim.ui.select(P.tabline.buf_names, {
			prompt = prompt,
			main = { current = true },
		}, function(choice)
			opts.format = P.tabline.format
			P.tabline.instance.setup(opts)
			if choice ~= nil then
				local cmd = buffCmd .. P.tabline.buffers[choice]
				vim.cmd(cmd)
			end
		end)
	end,

	set_hl_colors = function()
		-- Follows catpuccin mocha colors
		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { underline = false, italic = true, bold = true })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#6C7086", bg = "#181825" })
		vim.api.nvim_set_hl(
			0,
			"MiniTablineModifiedCurrent",
			{ underline = false, italic = true, bold = true, fg = "#FAB387" }
		)
		vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { italic = true, fg = "#F9E2AF", bg = "#181825" })
		vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = "#11111b" })
	end,
}

P.config = {
	{ "echasnovski/mini.move", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.bufremove", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.splitjoin", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.pairs", version = "*", opts = {}, event = { "BufReadPre", "BufNewFile" } },
	{ "echasnovski/mini.icons", version = "*", opts = { style = "glyph" }, lazy = true },
	{
		"echasnovski/mini.comment",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				comment_visual = "gc",
				textobject = "gc",
			},
		},
	},
	{
		"echasnovski/mini.hipatterns",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
					hack = { pattern = "HACK", group = "MiniHipatternsHack" },
					todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
					note = { pattern = "NOTE", group = "MiniHipatternsNote" },
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"echasnovski/mini.tabline",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
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
				"<leader>tc",
				function()
					vim.cmd([[:%bd|e#|bd#]])
				end,
				desc = "Close all buffers except current (Tabs)",
				mode = "n",
			},
		},
		opts = {
			show_icons = true,
			tabpage_section = "right",
			set_vim_settings = true,
		},
		config = function(_, opts)
			local tabline = require("mini.tabline")
			P.tabline.instance = tabline

			opts.format = P.tabline.format
			P.tabline.instance.setup(opts)

			vim.keymap.set("n", "<leader>tx", function()
				P.tabline.process_by_ordinal("bdelete", " Close buffer:", opts)
			end, { desc = "Close buffer by ordinal [Tabs]" })

			vim.keymap.set("n", "<leader>tt", function()
				P.tabline.process_by_ordinal("b", " Go to buffer:", opts)
			end, { desc = "Go to buffer by ordinal [Tabs]" })

			P.tabline.set_hl_colors()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add [S]urrounding (Surround)", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "[D]elete [S]urrounding (Surround)" },
				{ opts.mappings.find, desc = "[F]ind Right [S]urrounding (Surround)" },
				{ opts.mappings.find_left, desc = "Find Left [S]urrounding (Surround)" },
				{ opts.mappings.highlight, desc = "Highlight Surrounding (Surround)" },
				{ opts.mappings.replace, desc = "[C]hange [S]urrounding (Surround)" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines` (Surround)" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "S", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "fs", -- Find surrounding (to the right)
				find_left = "Fs", -- Find surrounding (to the left)
				highlight = "", -- Highlight surrounding
				replace = "cs", -- Replace surrounding
				update_n_lines = "", -- Update `n_lines`
			},
		},
	},
}

return P.config
