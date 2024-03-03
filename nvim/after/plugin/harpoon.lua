local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>ha", mark.add_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end)

vim.keymap.set("n", "<leader>hn", function() ui.nav_next() end)
vim.keymap.set("n", "<leader>hp", function() ui.nav_prev() end)

vim.keymap.set({"i","n","v","t"}, "<M-Space>", function() ToggleTerminal() end)

function ToggleTerminal()
    local buf = vim.fn.bufnr('%')
    local type = vim.api.nvim_buf_get_option(buf, 'buftype')

    if type:match("terminal") then
        vim.cmd("tabclose")
        vim.cmd("buffer#")
        vim.o.showtabline = 1
    else
        vim.o.showtabline = 0
        term.gotoTerminal(1)
        vim.cmd("tab split")
        vim.cmd("startinsert")
    end
end

