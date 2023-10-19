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
    lsp.preset()

    lsp.ensure_installed({
      "tsserver",
      "eslint",
      "lua_ls",
    })

    -- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.on_attach(function(_, _)
      local dap = require("dap")
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
        K = { "<cmd>LspUI hover<cr>", "Symbol information" },
        ["<F2>"] = { "<cmd>LspUI rename<cr>", "Rename" },
        ["<leader>"] = {
          d = {
            name = "Debbuger",
            t = { function() dapui.toggle() end, "Toggle" },
            e = { function() dapui.eval() end, "Evaluate value" },
            b = { function() dap.toggle_breakpoint() end, "Toggle breakpoint" },
          },
        },
        g = {
          f = { "<cmd>LspUI reference<cr>", "Symbol finder" },
          d = { "<cmd>LspUI definition<cr>", "Symbol definition" },
          D = { vim.lsp.buf.declaration, "Symbol declaration" },
          a = { "<cmd>LspUI code_action<cr>", "Symbol declaration" },
          I = { "<cmd> Telescope diagnostics <cr>", "Diagnose Buffers" }
        }
      })
    end)


    local cmp_action = lsp.cmp_action()
    lsp.setup()
    cmp.setup({
      window = {
        documentation = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          border = "single",
          scrollbar = false,
        },
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
          scrollbar = false,
          border = "single"
        },
      },
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 30, ellipsis_char = '', })(
            entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = ""
          return kind
        end,
      },
      mapping = {
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }
    })
  end
}
