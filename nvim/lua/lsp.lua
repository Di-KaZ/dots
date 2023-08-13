-- LSP Zero
local cmp = require('cmp')
local lsp = require('lsp-zero');
lsp.preset({})

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "lua_ls",
})

require 'lspconfig'.lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    library = { vim.env.VIMRUNTIME }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}

lsp.set_sign_icons({
    error = '󰅙',
    warn = '󰋼',
    hint = '󰌵',
    info = '󰋽'
})

lsp.on_attach(function(_, _)
    -- lsp.default_keymaps({ buffer = bufnr, omit = {'gr', 'K'} })
    lsp.buffer_autoformat()
    local wk = require("which-key")

    wk.register({
        K = { vim.lsp.buf.hover, "Symbol information" },
        ["<F2>"] = { vim.lsp.buf.rename, "Rename" },
        g = {
            r = { "<cmd> Telescope lsp_references <cr>", "Symbol references" },
            i = { "<cmd> Telescope lsp_implementations <cr>", "Symbol implementation" },
            d = { "<cmd> Telescope lsp_definitions <cr>", "Symbol definition" },
            D = { vim.lsp.buf.declaration, "Symbol declaration" },
            a = { vim.lsp.buf.code_action, "Symbol declaration" },
            I = { "<cmd> Telescope diagnostics <cr>", "Diagnose Buffers" }
        }
    })
end)

lsp.setup()

local cmp_action = lsp.cmp_action()
cmp.setup({
    completion = {
        autocomplete = false
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
            mode = 'symbol',       -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
    },
    mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})
