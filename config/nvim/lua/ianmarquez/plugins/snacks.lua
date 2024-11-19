return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 0 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 1, padding = { 2, 1 } },
        { icon = " ", title = "Projects", section = "projects", indent = 1, padding = 1 },
        { section = "startup" },
      },
    }
    ,
    git = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    quickfile = { enabled = true },
    rename = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    words = { enabled = false },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    { "<leader>gb", function() Snacks.git.blame_line() end,   desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end,        desc = "Git Browse" },
    { "<leader>tg", function() Snacks.lazygit() end,          desc = "Lazygit" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end,      desc = "Lazygit Log (cwd)" },
  },
}
