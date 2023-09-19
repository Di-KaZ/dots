return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    transparent = false,   -- do not set background color
    dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    theme = "wave",        -- Load "wave" theme when 'background' option is not set
    background = {         -- map the value of 'background' option to a theme
      dark = "wave",       -- try "dragon" !
      light = "lotus"
    },
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
  end
}
