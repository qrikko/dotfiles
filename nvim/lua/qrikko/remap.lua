vim.g.mapleader = " "
-- <C-\\><C-n>
--vim.keymap.set("t", "<Esc>", function() vim.cmd("stopinsert") end , { noremap = true, expr = true, silent = true })
vim.keymap.set('t', "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>P", "\"_dp")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")
vim.keymap.set("n", "<leader>D", "\"+D")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>r", ":%s/<C-r><C-w>//gI<Left><Left><Left><Space><Backspace>")
vim.keymap.set("n", "<leader>bb", ":Telescope buffers<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")
vim.keymap.set("n", "<leader>bk", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bt", ":buffer#<CR>")

vim.keymap.set("n", "<leader>k", "[m[{")
vim.keymap.set("n", "<leader>j", "][")

vim.keymap.set("n", "<leader>m", "[mV][")
vim.keymap.set("v", "<leader>m", "[mV][")
vim.keymap.set("n", "<leader>f", "[mV][zf")
vim.keymap.set("v", "<leader>f", "zf")
vim.keymap.set("n", "<leader>F", "zo")

