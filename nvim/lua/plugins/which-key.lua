return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    key_labels = {
      ["<space>"] = "SPACE",
      ["<leader>"] = "SPACE",
      ["<cr>"] = "RETURN",
      ["<tab>"] = "TAB",
    },
    window = {
      border = "single",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 0, 0, 0, 0 },
      winblend = 0,
    },
    icons = {
      breadcrumb = "",
      separator = "",
      group = " ",
    },
    -- triggers_nowait = {
    --   -- marks
    --   "<leader>",
    --   "`",
    --   "'",
    --   "g`",
    --   "g'",
    --   -- registers
    --   '"',
    --   "<c-r>",
    --   -- spelling
    --   "z=",
    -- },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      -- -- Better window navigation
      ["<C-h>"] = { "<C-w><C-h>", "Navigate windows to the left" },
      ["<C-j>"] = { "<C-w><C-j>", "Navigate windows down" },
      ["<C-k>"] = { "<C-w><C-k>", "Navigate windows up" },
      ["<C-l>"] = { "<C-w><C-l>", "Navigate windows to the right" },
      -- Move with shift-arrows
      ["<S-Left>"] = { "<C-w><S-h>", "Move window to the left" },
      ["<S-Down>"] = { "<C-w><S-j>", "Move window down" },
      ["<S-Up>"] = { "<C-w><S-k>", "Move window up" },
      ["<S-Right>"] = { "<C-w><S-l>", "Move window to the right" },
      -- -- Resize with arrows
      -- ["<ALT-Up>"] = { "<cmd>resize +2<CR>" },
      -- ["<ALT-Down>"] = { "<cmd>resize -2<CR>" },
      -- ["<ALT-Left>"] = { "<cmd>vertical resize +2<CR>" },
      -- ["<ALT-Right>"] = { "<cmd>vertical resize -2<CR>" },
      ["<leader>"] = {
        b = { "<cmd>ToggleBlame virtual<cr>", "Toggle Blame" },
        g = { "<cmd>Neogit<cr>", "Git" },
        d = {
          w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnose workspace" },
        },
        f = {
          name = "Files",
          t    = { function() require('FTerm').toggle() end, "Open terminal" },
          f    = { "<cmd>Telescope find_files<cr>", "Find Files" },
          g    = { "<cmd>Telescope live_grep<cr>", "Find grep" },
          o    = { "<cmd>Telescope buffers<cr>", "opened files" },
        },
        p = {
          v = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true <cr>", "File browser" },
          f = { "<cmd>NvimTreeToggle<cr>", "File browser new" }
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
