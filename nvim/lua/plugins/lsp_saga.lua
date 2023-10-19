return {
  enabled = false,
  'nvimdev/lspsaga.nvim',
  opts = {},
  config = function()
    require('lspsaga').setup({
      ui = {
        code_action = '',
      },
      lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
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
