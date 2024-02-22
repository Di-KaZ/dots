return {
  {
    'Biscuit-Colorscheme/nvim',
    enabled = false,
    priority = 1000,
  },
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
    'rebelot/kanagawa.nvim',
    enabled = false,
    config = function()
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
    end
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
    'DanielEliasib/sweet-fusion',
    enabled = true,
    name = 'sweet-fusion',
    priority = 1000,
    opts = {
      -- Set transparent background
      transparency = true,
      dim_inactive = true,
    }
  },
  {
    "kihachi2000/yash.nvim",
    enabled = false,
    priority = 1000,
    lazy = false,

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
    enabled = false,
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
