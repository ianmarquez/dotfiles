-- Utility function to check if any ESLint config file exists
local function eslint_config_exists()
	local configs = {
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc",
		"package.json",
	}

	for _, name in ipairs(configs) do
		local path = vim.fn.getcwd() .. "/" .. name
		local stat = vim.loop.fs_stat(path)
		if stat then
			if name == "package.json" then
				-- Check if ESLint is mentioned in package.json
				local file = io.open(path, "r")
				if file then
					local contents = file:read("*a")
					file:close()
					if contents:match('"eslint"') then
						return true
					end
				end
			else
				return true
			end
		end
	end
	return false
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		linters_by_ft = {
			go = { "golangcilint" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		if eslint_config_exists() then
			for _, value in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" }) do
				opts.linters_by_ft[value] = { "eslint_d" }
			end
		end

		lint.linters_by_ft = opts.linters_by_ft

		if eslint_config_exists() then
			local eslint = lint.linters.eslint_d
			eslint.args = {
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			}
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint(nil)
			end,
		})
	end,
	keys = {
		{
			"<leader>ml",
			function()
				require("lint").try_lint(nil)
			end,
			desc = "Trigger linting for current file (Nvim-lint)",
			mode = { "n", "v" },
		},
	},
}
