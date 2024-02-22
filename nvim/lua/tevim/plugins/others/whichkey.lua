local configs = {
	setup = {
		operators = { gc = "Comments" },
		key_labels = {
			["<space>"] = "SPACE",
			["<leader>"] = "SPACE",
			["<cr>"] = "RETURN",
			["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "",
			separator = "",
			group = " ",
		},
		layout = {
			height = { min = 3, max = 20 },
			width = { min = 20, max = 50 },
			spacing = 15,
			align = "center",
		},
		ignore_missing = true,
		show_help = true,
		triggers = { "<leader>" },
		triggers_blacklist = {
			i = { "j", "k" },
			v = { "j", "k" },
		},
	},

	mappings = {
		["q"] = { "<cmd>qa!<CR>", "Quit" },
		p = {
			name = "󰏖  LAZY",
			C = { "<cmd>Lazy clean<cr>", "Clean" },
			c = { "<cmd>Lazy log<cr>", "Log" },
			i = { "<cmd>Lazy install<cr>", "Install" },
			s = { "<cmd>Lazy sync<cr>", "Sync" },
			S = { "<cmd>Lazy show<cr>", "Status" },
			u = { "<cmd>Lazy update<cr>", "Update" },
		},
		o = {
			name = "  OPTIONS",
			s = { "<cmd>lua require('tevim.core.utils').toggle_option('spell')<cr>", "Spell" },
			n = { "<cmd>lua require('tevim.core.utils').toggle_option('number')<cr>", "Number" },
			r = { "<cmd>lua require('tevim.core.utils').toggle_option('relativenumber')<cr>", "Relative Number" },
		},
		w = {
			name = "  WINDOWS",
			v = { "<C-w>v", "Vertical Split" },
			h = { "<C-w>s", "Horizontal Split" },
			e = { "<C-w>=", "Make Splits Equal" },
			q = { "<cmd>close<CR>", "Close Split" },
			c = { "<cmd>TeBufCloseOtherBuf<CR>", "Close Other Buffers" },
		},
		f = {
			name = "  TELESCOPE",
			c = { "<cmd>lua require('tevim.themes.switch').setup()<cr>", "TeVim Themes" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
			w = { "<cmd>Telescope live_grep<cr>", "Find Text" },
			m = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			j = { "<cmd>Telescope commands<cr>", "Commands" },
			h = { "<cmd>Telescope highlights<cr>", "Highlights" },
			p = { "<cmd>Telescope projects<cr>", "Projects" },
			t = { "<cmd>TodoTelescope<cr>", "Todo" },
		},
		g = {
			name = "󰊢  GIT",
			l = { "<cmd>lua require('tevim.core.utils').LazyGit()<cr>", "Lazygit" },
			j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
			o = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
			c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
			d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
			n = { "<cmd>Neogit<cr>", "Neogit" },
		},
		c = {
			name = "  LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			I = { "<cmd>LspInfo<cr>", "Info" },
			i = { "<cmd>lua require('tevim.core.utils').toggle_inlayHint()<cr>", "Toggle Inlay Hint" },
			j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
			k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "Prev Diagnostic" },
			o = { "<cmd>Lspsaga outline<cr>", "Outline" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
		},
		d = {
			name = "  Debugger",
			t = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle DAP ui" },
		},
		s = {
			name = "  TREESITTER",
			c = { "<cmd>TSContextToggle<cr>", "Toggle Context" },
			i = { "<cmd>TSInstallInfo<cr>", "Info" },
			s = { "<cmd>TSUpdate<cr>", "Update" },
		},
		t = {
			name = "  TERMINAL",
			["1"] = { "<cmd>1ToggleTerm<cr>", "1" },
			["2"] = { "<cmd>2ToggleTerm<cr>", "2" },
			["3"] = { "<cmd>3ToggleTerm<cr>", "3" },
			["4"] = { "<cmd>4ToggleTerm<cr>", "4" },
			f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
			h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
			v = { "<cmd>ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
		},
	},

	opts = {
		mode = "n",
		prefix = "<leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = true,
	},
}

return configs