return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        vim.g.mapleader = ' '
    end,
    opts = {
        triggers_nowait = {
            -- marks
            "<leader>",
            "`",
            "'",
            "g`",
            "g'",
            -- registers
            '"',
            "<c-r>",
            -- spelling
            "z=",
        },
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}
