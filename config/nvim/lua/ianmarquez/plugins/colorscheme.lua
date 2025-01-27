return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({})

      -- vim.cmd('colorscheme github_light_high_contrast')
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        integrations = {
          gitsigns = true,
          mason = true,
          native_lsp = { enabled = true },
          nvimtree = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          symbols_outline = true,
        },
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
}
