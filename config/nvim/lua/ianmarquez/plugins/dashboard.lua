vim.g.dashboard_default_executive = "telescope"
return {
  "glepnir/dashboard-nvim",
  event = "UIEnter",
  opts = {
    change_to_vcs_root = true,
    theme = "hyper",
    config = {
      project = { enable = true, limit = 10, action = "Telescope find_files cwd=" },
      mru = { limit = 10 },
      week_header = {
        enable = false,
      },
      shortcut = {
        { desc = "󰊳 Update", group = "@property", action = "Lazy", key = "u" },
        {
          icon = " ",
          icon_hl = "@variable",
          desc = "Files",
          group = "Label",
          action = "Telescope find_files",
          key = "f",
        },
      },
    },
  },
}
