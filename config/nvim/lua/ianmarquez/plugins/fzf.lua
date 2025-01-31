return {
  "ibhagwan/fzf-lua",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = { "telescope" },
  keys = {
    { "<leader>fs", "<cmd>FzfLua live_grep<cr>",            desc = "Live Grep" },
    { "<leader>fc", "<cmd>FzfLua lgrep_curbuf<cr>",         desc = "Live Grep Current Buffer" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "Buffers" },
    { "<leader>ff", "<cmd>FzfLua files<cr>",                desc = "Files" },
    { "<leader>o",  "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Symbols in Current File" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>",              desc = "Keymaps" },
    { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>",     desc = "Code Actions" },
    { "gf",         "<cmd>FzfLua lsp_references<cr>",       desc = "Show LSP references" },
    { "gD",         "<cmd>FzfLua lsp_typedefs<cr>",         desc = "Show Type Definitions" },
    { "gd",         "<cmd>FzfLua lsp_definitions<cr>",      desc = "Show Definitions" },
  },
}
