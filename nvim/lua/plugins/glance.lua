return {
  'dnlhc/glance.nvim',
  config = function()
    require('glance').setup({
      height = 18, -- Height of the window
      zindex = 45,

      -- By default glance will open preview "embedded" within your active window
      -- when `detached` is enabled, glance will render above all existing windows
      -- and won't be restiricted by the width of your active window
      detached = false,

      -- -- Or use a function to enable `detached` only when the active window is too small
      -- -- (default behavior)
      -- detached = function(winid)
      --   return vim.api.nvim_win_get_width(winid) < 100
      -- end,
      preview_win_opts = { -- Configure preview window options
        cursorline = true,
        number = true,
        wrap = false,
      },
      border = {
        enable = true, -- Show window borders. Only horizontal borders allowed
        top_char = '―',
        bottom_char = '―',
      },
      list = {
        position = 'left', -- Position of the list window 'left'|'right'
        width = 0.33,      -- 33% width relative to the active window, min 0.1, max 0.5
      },
      theme = {            -- This feature might not work properly in nvim-0.7.2
        enable = false,    -- Will generate colors for the plugin based on your current colorscheme
        mode = 'auto',     -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
      },
    })
  end
}
