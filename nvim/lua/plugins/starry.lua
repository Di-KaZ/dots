return {
  'ray-x/starry.nvim',
  priority = 1000,
  lazy = false,
  opts = {

  },
  config = function(_, opts)
    vim.g.starry_bold = true   --set to false to disable bold globally
    vim.g.starry_italic = true --set to false to disable italic globally
    vim.g.starry_italic_comments = true
    vim.g.starry_italic_string = false
    vim.g.starry_italic_keywords = true
    vim.g.starry_italic_functions = true
    vim.g.starry_italic_variables = false
    vim.g.starry_contrast = true
    vim.g.starry_borders = false
    vim.g.starry_disable_background = false --set to true to disable background and allow transparent background
    vim.g.starry_style_fix = true           --disable random loading
    vim.g.starry_style = "dracula"          --load moonlight everytime or
    vim.g.starry_darker_contrast = true     --darker background
    vim.g.starry_deep_black = false         --OLED deep black
    vim.g.starry_italic_keywords = false
    vim.g.starry_italic_functions = false
    vim.g.starry_set_hl = true           -- Note: enable for nvim 0.6+, it is faster (loading time down to 4~6s from 7~11s), but it does
    -- not overwrite old values and may has some side effects
    vim.g.starry_daylight_switch = false --this allow using brighter color
    -- other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
  end
}
