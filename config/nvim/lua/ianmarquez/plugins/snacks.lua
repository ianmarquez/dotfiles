return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        { icon = " ", title = "Projects", section = "projects", padding = { 2, 1 } },
        -- { icon = " ", title = "Recent Files", section = "recent_files", indent = 1, padding = 1 },
        { section = "startup" },
      },
    },
    git = { enabled = false },
    input = { enabled = true, position = "bottom" },
    indent = {
      animate = { enabled = false },
      enabled = false,
      only_current = true,
      only_scope = true,
      scope = { enabled = true, underline = true, },
    },
    notifier = { enabled = true, timeout = 1500 },
    notify = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = false },
    terminal = { enabled = true },
    toggle = { enabled = false },
    words = { enabled = false },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    { "<c-/>",      function() require("snacks").terminal.toggle() end,             desc = "Terminal" },
    { "<leader>tv", function() require("snacks").terminal.toggle("lazydocker") end, desc = "LazyDocker" },
    { "<leader>gb", function() require("snacks").git.blame_line() end,              desc = "Git Blame Line" },
    { "<leader>gB", function() require("snacks").gitbrowse() end,                   desc = "Git Browse" },
    { "<leader>tg", function() require("snacks").lazygit() end,                     desc = "Lazygit" },
    { "<leader>gf", function() require("snacks").lazygit.log_file() end,            desc = "Lazygit Current File History" },
    { "<leader>gl", function() require("snacks").lazygit.log() end,                 desc = "Lazygit Log (cwd)" },
    { "<leader>nd", function() require("snacks").notifier.hide() end,               desc = "Dismiss Notifications" },
    { "<leader>nn", function() require("snacks").notifier.show_history() end,       desc = "Show Notifications" },
  },
}
