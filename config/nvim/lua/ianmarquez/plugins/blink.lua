return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {
      enable_events = true,
    },
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
      {
        "MattiasMTS/cmp-dbee",
        dependencies = "kndndrj/nvim-dbee",
        ft = "sql", -- optional but good to have
        opts = {},  -- needed
      },
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'dbee' },
        providers = {
          dbee = {
            name = "cmp-dbee",
            module = 'blink.compat.source',
            score_offset = 1,
          }
        }
      },
      keymap = {
        preset = 'default',
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_next", "fallback" },

        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        cmdline = {
          preset = 'default',
          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-j>"] = { "select_prev", "fallback" },
          ["<C-k>"] = { "select_next", "fallback" },
        }
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
    },
  },
}
