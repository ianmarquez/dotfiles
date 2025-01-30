return {
  { "echasnovski/mini.bufremove", event = { "BufReadPre", "BufNewFile" }, version = false },
  {
    'echasnovski/mini.tabline',
    version = '*',

    event = "UIEnter",
    keys = {
      { "<S-h>",      ":bprev<CR>",      desc = "Previous buffer",                  mode = "n" },

      { "<S-l>",      ":bprev<CR>",      desc = "Next buffer",                      mode = "n" },
      { "<leader>tx", ":bdelete<CR>",    desc = "Close current buffer",             mode = "n" },
      { "<leader>tc", ":%bd|e#|bd#<CR>", desc = "Close all buffers except current", mode = "n" },
    },
    opts = {
      show_icons = true,
      tabpage_section = "right",
      set_vim_settings = true,
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and '' or ''
        local readonly = vim.bo[buf_id].modifiable and '' or ''
        return " " .. readonly .. MiniTabline.default_format(buf_id, label) .. suffix .. " "
      end
    },
    config = function(_, opts)
      require("mini.tabline").setup(opts)
      vim.api.nvim_set_hl(0, "MiniTablineCurrent", { underline = false, italic = true, bold = true })
      vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#6C7086" })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent",
        { underline = false, italic = true, bold = true, fg = "#FAB387" })
      vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { italic = true, fg = "#F9E2AF" })
      vim.api.nvim_set_hl(0, "MiniTablineFill", { fg = "#11111B" })
    end
  },
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add Surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete Surrounding" },
        { opts.mappings.find,           desc = "Find Right Surrounding" },
        { opts.mappings.find_left,      desc = "Find Left Surrounding" },
        { opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { opts.mappings.replace,        desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
}
