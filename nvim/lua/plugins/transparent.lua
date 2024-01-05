return {
  'xiyaowong/transparent.nvim',
  opts = {
    groups = {
      'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
      'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
      'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
      'SignColumn', 'CursorLineNr', 'EndOfBuffer',
      'TelescopeBorder',
      'NormalFloat',
      'FloatBorder',
      'TelescopeNormal',
      'NoiceConfirmBorder',
      'NoiceCmdLinePopupBorder',
      'NoiceCmdLineIcon',
      'GitSignsUntracked',
      'GitSignsChange',
      'GitSignsDelete',
      'GitSignsAddNr',
      'GitSignsAdd',
      'GlanceWinBarTitle',
      'GlanceWinBarFilename',
      'GlanceWinBarFilepath',
      'NeoTreeVertSplit',
      'NeoTreeWinSeparator',
      'NeoTreeNormal',
      'NeoTreeNormalNC',
      'NeoTreeRootName',
      'NeoTreeEndOfBuffer',
    },
  },
  config = function(_, opts)
    require("transparent").setup(opts)
  end
}
