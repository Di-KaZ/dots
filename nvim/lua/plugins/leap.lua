return {
  "ggandor/leap.nvim",
  enabled = false,
  dependencies = { "tpope/vim-repeat" },
  opts = {},
  config = function(_, opts)
    require('leap').add_default_mappings()
  end,
}
