return {
  "voldikss/vim-floaterm",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<F1>",       ":FloatermToggle<cr>",         desc = "Toggle Floaterm" },
    { "<leader>tn", ":FloatermNew<cr>",            desc = "New Floaterm" },
    { "<leader>tv", ":FloatermNew lazydocker<cr>", desc = "LazyDocker" },
  },
  init = function()
    vim.g.floaterm_keymap_toggle = "<F1>"
    vim.g.floaterm_width = 0.95
    vim.g.floaterm_height = 0.95
    vim.g.floatterm_wintitle = 1
    vim.g.floaterm_autoclose = 1
  end,
}
