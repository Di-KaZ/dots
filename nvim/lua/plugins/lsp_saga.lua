return {
  'nvimdev/lspsaga.nvim',
  opts = {},
  config = function()
    require('lspsaga').setup({
      ui = {
        code_action = '',
      },
      light_bulb = {
        virutal_text = false,
      },
      implement = {
        enable = true
      }
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'      -- optional
  }
}
