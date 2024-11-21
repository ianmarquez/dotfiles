return {
  "ibhagwan/fzf-lua",
  lazy = true,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    "telescope",
    files = {
      -- cwd_prompt = false
    }
  },
  keys = {
    { "<leader>fs", "<cmd>FzfLua live_grep<cr>",            desc = "FZF Live Grep" },
    { "<leader>fc", "<cmd>FzfLua lgrpe_curbuf<cr>",         desc = "FZF Live Grep Current Buffer" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "FZF Buffers" },
    { "<leader>ff", "<cmd>FzfLua files<cr>",                desc = "FZF Files" },
    { "<leader>o",  "<cmd>FzfLua lsp_document_symbols<cr>", desc = "FZF Symbols in Current File" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>",              desc = "FZF Keymaps" },
    { "<leader>gf", "<cmd>FzfLua lsp_references<cr>",       desc = "Show LSP references" },
    { "<leader>gD", "<cmd>FzfLua lsp_typedefs<cr>",         desc = "Show Type Definitions" },
    { "<leader>gd", "<cmd>FzfLua lsp_definitions<cr>",      desc = "Show Definitions" },
  },
}
