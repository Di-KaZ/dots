return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    prompt = {
      enabled = false,
      -- prefix = { { "⚡", "FlashPromptIcon" } },
      -- win_config = {
      --   relative = "editor",
      --   width = 1, -- when <=1 it's a percentage of the editor width
      --   height = 1,
      --   row = -1,  -- when negative it's an offset from the bottom
      --   col = 0,   -- when negative it's an offset from the right
      --   zindex = 1000,
      -- },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    {
      "<c-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc =
      "Toggle Flash Search"
    },
  },
}
