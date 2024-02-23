local overrides = require("custom.configs.overrides")

local plugins = {
	-- add plugins or override my plugins in here
	{
		"rasulomaroff/reactive.nvim",
		config = true,
		opts = {
			builtin = {
				cursorline = true,
				cursor = true,
				modemsg = true,
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
		},
		config = true,
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
		opts = {
			dev_log = {
				enabled = false,
			},
			widget_guides = {
				enabled = false,
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = {},
			},
		},
	},
	{
		"dnlhc/glance.nvim",
		config = true,
		opts = {
			border = {
				enable = false,
			},
			list = {
				position = "left",
				width = 0.33,
			},
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		name = "dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {
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
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "+",
				current_frame = "",
				expanded = "-",
			},
			layouts = {
				{
					elements = {
						-- {
						-- 	id = "scopes",
						-- 	size = 0.25,
						-- },
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 30,
				},
				{
					elements = { {
						id = "repl",
						size = 1,
					} },
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		},
		config = function(_, opts)
			require("dapui").setup(opts)
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			notify = {
				view = "mini",
			},
			lsp = {
				signature = {
					enabled = false,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}

return plugins
