return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "HiPhish/rainbow-delimiters.nvim" },
  opts = {},
  config = function(_, opts)
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    require("ibl").setup({
      indent = { char = '┊' },
    })


    -- local hooks = require "ibl.hooks"
    -- -- create the highlight groups in the highlight setup hook, so they are reset
    -- -- every time the colorscheme changes
    -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --   print("hola ke tal")
    --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    -- end)
    --
    -- vim.g.rainbow_delimiters = { highlight = highlight }
    -- require("ibl").setup { scope = {
    --   highlight = highlight,
    --   include = {
    --     node_type = {
    --       svelte = {
    --         "start tag",
    --       },
    --       dart = {
    --         "class_definition",
    --         "factory_constructor_signature",
    --         "identifier",
    --         "siwtch_statement",
    --         "siwtch_statement_case",
    --         "case_builtin",
    --         "switch_expression",
    --         "switch_statement_default",
    --         "return_Statement",
    --         "expression_statement",
    --         "switch_block",
    --         "arguments",
    --         "list_literal",
    --       },
    --       lua = {
    --         'chunk',
    --         'do_statement',
    --         'while_statement',
    --         'repeat_statement',
    --         'if_statement',
    --         'for_statement',
    --         'function_declaration',
    --         'function_definition',
    --         'table_constructor',
    --         'assignment_statement',
    --       },
    --       typescript = {
    --         'statement_block',
    --         'function',
    --         'arrow_function',
    --         'function_declaration',
    --         'method_definition',
    --         'for_statement',
    --         'for_in_statement',
    --         'catch_clause',
    --         'object_pattern',
    --         'arguments',
    --         'switch_case',
    --         'switch_statement',
    --         'switch_default',
    --         'object',
    --         'object_type',
    --         'ternary_expression',
    --       },
    --     },
    --   },
    -- }, indent = { char = '┊' } }
    --
    -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end
}
