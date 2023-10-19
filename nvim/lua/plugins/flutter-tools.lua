return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = true,
  opts = {
    dev_log = {
      enabled = false
    },
    widget_guides = {
      enabled = false
    },
    debugger = {
      enabled = true,
      run_via_dap = false,
      exception_breakpoints = {},
    }
  }
}
