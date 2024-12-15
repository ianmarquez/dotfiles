return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    lint.linters_by_ft = opts.linters_by_ft
    local eslint = lint.linters.eslint_d
    eslint.args = {
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil)
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>ml", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
