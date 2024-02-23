-- add your keymaps in here
local map = vim.keymap.set

local opts = { noremap = false, silent = true }

-- map("n", "gr", "<CMD>Glance references<CR>", opts, { desc = "Find References" })
-- map("n", "gd", "<CMD>Glance definitions<CR>", opts, { desc = "Find Definitions" })
-- map("n", "gD", "<CMD>Glance type_definitions<CR>", opts, { desc = "Type Definitions" })
-- map("n", "gI", "<CMD>Glance implementations<CR>", opts, { desc = "Find Implementations" })
map("n", "K", "<CMD>Lspsaga hover_doc<CR>", opts, { desc = "Find Implementations" })
map("n", "gd", "<CMD>Lspsaga finder def ++normal<CR>", opts, { desc = "Type Definitions" })
map("n", "gr", "<CMD>Lspsaga finder ref ++normal<CR>", opts, { desc = "Find References" })
