return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate",
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- tool installer to ensure formatters and linters are installed
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "gopls",
        "svelte",
        "sqlls",
        "rust_analyzer",
        "graphql",
        "vuels",
        "prismals",
        "templ",
        "omnisharp"
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    -- auto-install configured formatters & linters (with mason-tool-installer)
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "prettierd",
        "eslint_d",

        "goimports",
        "golines",
        "golangci-lint",

        "stylua",
      },
    })
  end,
}
