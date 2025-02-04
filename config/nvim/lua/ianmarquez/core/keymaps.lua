vim.g.mapleader = " " -- <leader>

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No highlight" })
keymap.set("n", "x", '"_x"')
keymap.set("n", "J", "mzJ`z", { desc = "Delete line break" })
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv", { desc = "Next highlighted word" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous highlighted word" })
keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)

-- window controls
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically (Window)" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally (Window)" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equalize windows (Window)" })
keymap.set("n", "<leader>wq", ":close<CR>", { desc = "Close current window (Window)" })
keymap.set("n", "<M-h>", "<C-w>5<", { desc = "Adjust Split to Left (Window)" })
keymap.set("n", "<M-l>", "<C-w>5>", { desc = "Adjust Split to Right (Window)" })
keymap.set("n", "<M-j>", "<C-w>5+", { desc = "Adjust Split Down (Window)" })
keymap.set("n", "<M-k>", "<C-w>5-", { desc = "Adjust Split to Up (Window)" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
