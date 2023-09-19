return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- disable rtp plugin, as we only need its queries for mini.ai
        -- In case other textobject modules are enabled, we will load them
        -- once nvim-treesitter is loaded
        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        load_textobjects = true
      end,
    },
  },
  cmd = { "TSUpdateSync" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>",      desc = "Decrement selection", mode = "x" },
  },
  ---@type TSConfig
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)

    if load_textobjects then
      -- PERF: no need to load the plugin, if we only need its queries for mini.ai
      if opts.textobjects then
        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            local Loader = require("lazy.core.loader")
            Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
            local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
            require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
            break
          end
        end
      end
    end
    local cmp = require('cmp')
    local lsp = require('lsp-zero');
    local dapui = require("dapui")

    dapui.setup({
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
    }
    )

    lsp.preset()

    lsp.ensure_installed({
      "tsserver",
      "eslint",
      "lua_ls",
    })

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.on_attach(function(_, _)
      local dap = require("dap")
      -- local mocha = require("catppuccin.palettes").get_palette("mocha")

      -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = mocha.red })
      -- vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = mocha.green })
      -- vim.api.nvim_set_hl(0, 'DapStopped', { fg = mocha.rosewater })
      vim.fn.sign_define('DapBreakpoint', {
        text = '󰏥',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
      })

      vim.fn.sign_define('DapBreakpointCondition',
        {
          text = '󰏧',
          texthl = 'DapBreakpoint',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })

      vim.fn.sign_define('DapBreakpointRejected',
        {
          text = '󰄰',
          texthl = 'DapBreakpoint',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })

      vim.fn.sign_define('DapLogPoint', {
        text = '󰛐',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint'
      })

      vim.fn.sign_define('DapStopped',
        {
          text = '󰁔',
          texthl = 'DapStopped',
          linehl = 'DapStopped',
          numhl = 'DapStopped'
        })

      lsp.set_sign_icons({
        error = '',
        warn = '',
        hint = '',
        info = ''
      })

      vim.diagnostic.config({
        virtual_text = {
          -- source = "always",  -- Or "if_many"
          prefix = '■', -- Could be '■', '▎', 'x'
        },
        severity_sort = true,
        float = {
          source = "always", -- Or "if_many"
        },
      })

      lsp.buffer_autoformat()

      local wk = require("which-key")

      wk.register({
        K = { vim.lsp.buf.hover, "Symbol information" },
        ["<F2>"] = { vim.lsp.buf.rename, "Rename" },
        ["<leader>"] = {
          d = {
            name = "Debbuger",
            t = { function() dapui.toggle() end, "Toggle" },
            e = { function() dapui.eval() end, "Evaluate value" },
            b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
          },
        },
        g = {
          r = { "<cmd> Telescope lsp_references <cr>", "Symbol references" },
          i = { "<cmd> Telescope lsp_implementations <cr>", "Symbol implementation" },
          d = { "<cmd> Telescope lsp_definitions <cr>", "Symbol definition" },
          D = { vim.lsp.buf.declaration, "Symbol declaration" },
          a = { vim.lsp.buf.code_action, "Symbol declaration" },
          I = { "<cmd> Telescope diagnostics <cr>", "Diagnose Buffers" }
        }
      })
    end)


    local cmp_action = lsp.cmp_action()
    cmp.setup({
      completion = {
        autocomplete = false,
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
          mode = 'symbol',          -- show only symbol annotations
          maxwidth = 50,            -- prevent the popup from showing more than provided characters
          ellipsis_char = '(more)', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
      },
      mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }
    })

    lsp.setup()
    -- require("noice").setup({
    --   lsp = {
    --     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --     override = {
    --       -- override the default lsp markdown formatter with Noice
    --       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --       -- override the lsp markdown formatter with Noice
    --       ["vim.lsp.util.stylize_markdown"] = true,
    --       -- override cmp documentation with Noice (needs the other options to work)
    --       ["cmp.entry.get_documentation"] = true,
    --     },
    --     hover = { enabled = true },     -- <-- HERE!
    --     signature = { enabled = true }, -- <-- HERE!
    --   },
    -- })
  end
}
