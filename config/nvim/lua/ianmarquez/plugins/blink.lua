local blink_config = function()
  local default_binds = {
    preset = 'default',
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<Tab>"] = { "accept", "fallback" },
  }

  local combine = function(second_table, first_table)
    local merge = {}
    for k, v in pairs(first_table) do merge[k] = v end
    for k, v in pairs(second_table) do merge[k] = v end
    return merge
  end

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
        completion = {
          menu = { border = 'single' },
          documentation = {
            window = { border = 'single' },
            auto_show = true,
            auto_show_delay_ms = 500
          },
        },
        keymap = combine(
          default_binds,
          {
            ["<S-k>"] = { "scroll_documentation_up", "fallback" },
            ["<S-j>"] = { "scroll_documentation_down", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            cmdline = default_binds,
          }
        ),
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
      },
    },
  }
end;

return blink_config()
