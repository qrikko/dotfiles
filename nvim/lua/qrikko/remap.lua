vim.g.mapleader = " "
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dp")
vim.keymap.set("x", "<leader>P", "\"_dP")

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
vim.keymap.set("n", "<leader>bt", ":b term<CR>")

vim.keymap.set("n", "<leader>j", "[m0")
vim.keymap.set("n", "<leader>k", "][")
vim.keymap.set("n", "<leader>m", "[mV][")
vim.keymap.set("v", "<leader>m", "[mV][")


--vim.keymap.set("n", "<leader>[[", [[:lua PrevFuncStart()<CR>]])
--vim.keymap.set("v", "<leader>[[", [[<Cmd>lua PrevFuncStart()<CR>]])
--vim.keymap.set("n", "<leader>]]", [[:lua NextFuncEnd()<CR>]])
--vim.keymap.set("v", "<leader>]]", [[<Cmd>lua NextFuncEnd()<CR>]])
--
--vim.keymap.set("n", "<leader>{{", [[:lua PrevFuncEnd()<CR>]])
--vim.keymap.set("v", "<leader>{{", [[<Cmd>lua PrevFuncEnd()<CR>]])
--vim.keymap.set("n", "<leader>}}", [[:lua NextFuncStart()<CR>]])
--vim.keymap.set("v", "<leader>}}", [[<Cmd>lua NextFuncStart()<CR>]])
--

local pattern = '^%s*[%w_]+%s+[%w_]+%s*%([^%)]*%)%s*[{~]?%s*$'
local selection = {}

--[[

void func (int poo) {
    if (poo) {
        print ("hej%d", poo);
    }
}

void Foo(){
    // commented code
}


]]


function tprint(t)
    for key, value in ipairs(t) do
        print(key, value)
    end
end

function FindFuncStartLine(pos, dir)
    local offset = dir 
    local line = vim.fn.getline(pos+offset)
    local eof = vim.fn.line('$')

    while (pos+offset > 0 and pos+offset < eof) do
        if line:match(pattern) then
            return pos+offset
        end
        offset = offset + dir
        line = vim.fn.getline(pos + offset)
    end
    return pos
end

function FindFuncEndLine(pos)
--    local up = FindFuncStartLine(pos, -1)
--    local down = FindFuncStartLine(pos, 1)
--    local start = (pos-up > down-pos) and up or down

    local line = nil
    local eof = vim.fn.line('$')
    local offset = 0
    local cnt = 0
    local start = nil

    while (pos + offset < eof) do
        line = vim.fn.getline(pos+offset)
        if line:match('}') and offset > 0 then
            start = FindFuncStartLine(pos, -1)
            break
        elseif line:match(pattern) then
            start = pos+offset
            break
        end
        offset = offset + 1
    end
    
    offset = 0

    while (start+offset < eof) do
        line = vim.fn.getline(start+offset)
        local opencnt = select(2, line:gsub('{', ''))
        local closecnt = select(2, line:gsub('}', ''))
        cnt = c+nt + opencnt - closecnt
        if cnt<1 then
            break
        end
        offset = offset + 1
    end

    return start + offset
end

function PrevFuncStart()
    local pos = vim.fn.getpos('.')[2]
    local open = FindFuncStartLine(pos, -1)
    vim.fn.cursor(open, 1)
end

function PrevFuncEnd()
    local pos = vim.fn.getpos('.')[2]
    local open = FindFuncStartLine(pos, -1)
    open = FindFuncStartLine(open-1, -1)
    local close = FindFuncEndLine(open)
    vim.fn.cursor(close, 1)
end

function NextFuncStart()
    local pos = vim.fn.getpos('.')[2]
    local open = FindFuncStartLine(pos, 1)
    vim.fn.cursor(open, 1)
end

function NextFuncEnd()
    local pos = vim.fn.getpos('.')[2]
    local close = FindFuncEndLine(pos)
    vim.fn.cursor(close, 1)
end

function SelectFunc()
    local pos = vim.fn.getpos('.')[2]
    local open = FindFuncStartLine(pos, -1)
    local close = FindFuncEndLine(open)

    vim.fn.cursor(open, 1)
    vim.cmd("normal! V")
    vim.fn.cursor(close, 1)
end
