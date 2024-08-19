return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
  	local conform = require("conform")

  	conform.setup({
  		formatters_by_ft = {
  			javescript = { "prettierd" },
  			typescript = { "prettierd" },
  			javascriptreact = { "prettierd" },
  			typescriptreact = { "prettierd" },
  			svelte = { "prettierd" },
  			css = { "prettierd" },
  			html = { "prettierd" },
  			json = { "prettierd" },
  			yaml = { "prettierd" },
  			markdown = { "prettierd" },
  			graphql = { "prettierd" },

  			sql = { "sql_formatter" },

  			go = { "goimports", "gofmt", "golines" },

  			lua = { "stylua" },
  		},
  		format_after_save = {
  			lsp_fallback = true,
  		},
  	})

  	vim.keymap.set({ "n", "v" }, "<leader>mf", function()
  		conform.format({
  			async = true,
  			lsp_fallback = true,
  		})
  	end, { desc = "Format current selection" })
  end,
}
