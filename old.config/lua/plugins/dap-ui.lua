return {
  "rcarriga/nvim-dap-ui",
  name = 'dap-ui',
  dependencies = { "mfussenegger/nvim-dap" },
  opts =
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "+",
      current_frame = "",
      expanded = "-"
    },
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.25
      }, {
        id = "breakpoints",
        size = 0.25
      }, {
        id = "stacks",
        size = 0.25
      }, {
        id = "watches",
        size = 0.25
      } },
      position = "left",
      size = 30
    }, {
      elements = { {
        id = "repl",
        size = 1
      }, },
      position = "bottom",
      size = 10
    } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  },
  config = function(_, opts)
    require("dapui").setup(opts)
  end
}
