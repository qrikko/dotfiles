require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "cpp", "bash", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },

    textobjects = {
        move = {
            enabled = true,
            set_jumps = true,
            goto_next_start = {
                ["<leader>>"] = "@function.outer",
            },
            goto_next_end = {
                ["<leader><"] = "@function.outer",
            },

        },
    },
}

--local ts_move = require("nvim-treesitter.textobjects.move")
--vim.keymap.set('n', '<leader>,', ts_move.goto_next_start)
--vim.keymap.set('n', '<leader>.', ts_move.goto_next_end)
