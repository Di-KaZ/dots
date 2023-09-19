return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    triggers_nowait = {
      -- marks
      "<leader>",
      "`",
      "'",
      "g`",
      "g'",
      -- registers
      '"',
      "<c-r>",
      -- spelling
      "z=",
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.register({
      ["<leader>"] = {
        f = {
          name = "Files",
          t    = { function() require('FTerm').toggle() end, "Open terminal" },
          f    = { "<cmd>Telescope find_files<cr>", "Find Files" },
          g    = { "<cmd>Telescope live_grep<cr>", "Find grep" },
          o    = { "<cmd>Telescope buffers<cr>", "opened files" },

        },
        p = {
          v = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true <cr>", "File browser" }
        },
        t = {
          name = "Flutter",
          d = { "<cmd> FlutterDevices <cr>", "Flutter: Show devices" },
          c = { "<cmd> Telescope flutter commands <cr>", "Flutter: commands" },
          s = { "<cmd> FlutterOutlineToggle <cr>", "Open widget tree summary" },
        }
      }
    })
  end
}