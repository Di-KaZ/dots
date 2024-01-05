vim.g.mapleader = ' '
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.termguicolors = true
vim.opt.pumheight = 5
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- allow user config like .nvim.lua to be loaded per folder
vim.o.exrc = true

vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_hl(0, "DiffText", { bg = "#727169" })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#737064", undercurl = true })
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1f1f28" })


require("lazy").setup("plugins")


-- vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "nightcity"


-- Customization for Pmenu
-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = currentTelescopeBorder.fg, })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- Flash
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#C3E88D" })
vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#C792EA" })


-- diagnostic underline

vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underdotted = true, })
