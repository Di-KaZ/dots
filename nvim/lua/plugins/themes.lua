return {
  {
    enabled = false,
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
      }
      require('bamboo').load()
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic'.load()
    end
  },
  {
    'Yazeed1s/oh-lucy.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
  },
  {
    'Everblush/nvim',
    enabled = false,
    name = 'everblush',
  },
  {
    'cryptomilk/nightcity.nvim',
    -- enabled = false,
    priority = 1000,
    lazy = false,
    version = false,
    opts = {
      -- kabuki or afterlife
      style = 'afterlife',    -- The theme comes in two styles: kabuki or afterlife
      terminal_colors = true, -- Use colors used when opening a `:terminal`
      invert_colors = {
        -- Invert colors for the following syntax groups
        cursor = true,
        diff = false,
        error = true,
        search = true,
        selection = false,
        signs = false,
        statusline = true,
        tabline = false,
      },
      font_style = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        search = { bold = true },
      },
      -- Plugin integrations. Use `default = false` to disable all integrations.
      plugins = { default = true },
      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param groups Highlight groups
      ---@param colors ColorScheme
      on_highlights = function(groups, colors) end,
    }
  },
}
