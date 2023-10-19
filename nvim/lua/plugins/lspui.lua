return {
  "jinzhongjia/LspUI.nvim",
  branch = "main",
  config = function()
    require("LspUI").setup({
      -- config options go here
      lightbulb = {
        enable = false,
      }
    })
  end
}
