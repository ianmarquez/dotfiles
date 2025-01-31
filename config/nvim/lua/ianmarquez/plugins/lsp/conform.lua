return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "svelte-language-server", "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier", "jq" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },

        sql = { "sql_formatter" },

        go = { "goimports", "gofmt", "golines" },
        templ = { "templ" },

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
