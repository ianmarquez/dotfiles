return {
  {
    'echasnovski/mini.move',
    version = '*',
    event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },
  {
    'echasnovski/mini.hipatterns',
    version = '*',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          fixme     = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
          hack      = { pattern = 'HACK', group = 'MiniHipatternsHack' },
          todo      = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
          note      = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    'echasnovski/mini.notify',
    version = '*',
    lazy = true,
    config = function()
      require("mini.notify").setup()
    end
  },
  {
    'echasnovski/mini.splitjoin',
    event = { "BufReadPre", "BufNewFile" },
    version = '*',
    config = function(_, opts)
      require("mini.splitjoin").setup(opts)
    end
  },
  {
    "echasnovski/mini.icons",
    version = "*",
    opts = {
      style = "glyph"
    },
    lazy = true,
    specs = { { "nvim-tree/nvim-web-devicons", enabled = false, optional = true }, },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    'echasnovski/mini.tabline',
    version = '*',
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<S-h>",      ":bprev<CR>",          desc = "Previous buffer",                  mode = "n" },
      { "<S-l>",      ":bprev<CR>",          desc = "Next buffer",                      mode = "n" },
      { "<leader>tx", ":bdelete<CR>",        desc = "Close current buffer",             mode = "n" },
      { "<leader>tc", ":%bd|e#|bd#<CR><CR>", desc = "Close all buffers except current", mode = "n" },
    },
    opts = {
      show_icons = true,
      tabpage_section = "right",
      set_vim_settings = true,
    },
    config = function(_, opts)
      local tabline = require("mini.tabline")
      opts.format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and '' or ''
        local readonly = vim.bo[buf_id].modifiable and '' or ''
        local title = " " .. readonly .. tabline.default_format(buf_id, label) .. suffix .. " "
        return title
      end

      tabline.setup(opts)

      vim.api.nvim_set_hl(0, "MiniTablineCurrent", { underline = false, italic = true, bold = true })
      vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#6C7086" })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent",
        { underline = false, italic = true, bold = true, fg = "#FAB387" })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { italic = true, fg = "#F9E2AF" })
      vim.api.nvim_set_hl(0, "MiniTablineFill", { fg = "#313244" })
    end
  },
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {},
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
        { opts.mappings.add,            desc = "Add [S]urrounding",                   mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "[D]elete [S]urrounding" },
        { opts.mappings.find,           desc = "[F]ind Right [S]urrounding" },
        { opts.mappings.find_left,      desc = "Find Left [S]urrounding" },
        { opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { opts.mappings.replace,        desc = "[C]hange [S]urrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "S",           -- Add surrounding in Normal and Visual modes
        delete = "ds",       -- Delete surrounding
        find = "fs",         -- Find surrounding (to the right)
        find_left = "Fs",    -- Find surrounding (to the left)
        highlight = "",      -- Highlight surrounding
        replace = "cs",      -- Replace surrounding
        update_n_lines = "", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}
