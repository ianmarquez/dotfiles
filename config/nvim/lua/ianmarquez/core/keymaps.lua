vim.g.mapleader = " " -- <leader>

local keymap = vim.keymap -- for conciseness

-- keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

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

-- vim.keymap.set("", "<leader>dl", function()
-- 	vim.diagnostic.config({
-- 		virtual_lines = not vim.diagnostic.config().virtual_lines,
-- 		virtual_text = not vim.diagnostic.config().virtual_text,
-- 	})
-- end, { desc = "Show [d]iagnostic [l]ines" })
