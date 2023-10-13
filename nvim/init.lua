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
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1f1f28" })


require("lazy").setup("plugins")

local currentTelescopeBorder = vim.api.nvim_get_hl(0, { name = 'TelescopeBorder' })

-- vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "kanagawa"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = currentTelescopeBorder.fg, bg = "none" })

-- remove telescope border background
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = currentTelescopeBorder.fg, bg = "none" })

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = currentTelescopeBorder.fg, })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB" })

-- Flash
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#C3E88D" })
vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#C792EA" })
