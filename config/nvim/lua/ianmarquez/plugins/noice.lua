return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = { row = 10, col = "50%", },
        size = { width = 50, height = "auto", },
      },
    },
    cmdline = { enabled = true, view = "cmdline_popup", },
    messages = { enabled = false, },
    notify = { enabled = false, },
    routes = {
      {
        filter = { event = "msg_show", kind = "", find = "written", },
        opts = { skip = true },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      -- inc_rename = true,            -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
  },
}
