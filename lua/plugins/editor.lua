return {
	-- Flash.nvim is configured at the end of this file

	{
		"nvim-mini/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				hsl_color = {
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("solarized-osaka.hsl")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			},
		},
	},

	{
		"dinhhuy258/git.nvim",
		event = "BufReadPre",
		opts = {
			keymaps = {
				-- Open blame window
				blame = "<Leader>gb",
				-- Open file/folder in git repository
				browse = "<Leader>go",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		keys = {
			-- File search
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },

			-- Git
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

			-- LSP
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },

			-- Resume last picker
			{ "<leader>f.", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
		},
		opts = {
			defaults = {
				prompt_prefix = "🔍 ",
				selection_caret = "➜ ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "" },
				change = { text = "" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "" },
				untracked = { text = "" },
			},
		},
	},

	{
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>th",
				function()
					require("close_buffers").delete({ type = "hidden" })
				end,
				"Close Hidden Buffers",
			},
			{
				"<leader>tu",
				function()
					require("close_buffers").delete({ type = "nameless" })
				end,
				"Close Nameless Buffers",
			},
		},
	},

	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			-- Initialize toggle variable
			if vim.g.blink_cmp_enabled == nil then
				vim.g.blink_cmp_enabled = true
			end

			-- Override enabled function to check toggle
			opts.enabled = function()
				return vim.g.blink_cmp_enabled
			end

			opts.completion = opts.completion or {}
			opts.completion.menu = opts.completion.menu or {}
			opts.completion.menu.winblend = vim.o.pumblend

			opts.signature = opts.signature or {}
			opts.signature.enabled = true
			opts.signature.window = opts.signature.window or {}
			opts.signature.window.winblend = vim.o.pumblend

			opts.keymap = opts.keymap or {}
			opts.keymap.preset = "enter"
			opts.keymap["<C-n>"] = { "select_next", "fallback" }
			opts.keymap["<C-p>"] = { "select_prev", "fallback" }

			-- Custom Tab handler for UltiSnips integration
			opts.keymap["<Tab>"] = {
				function(cmp)
					-- First check if UltiSnips can expand or jump
					if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>(ultisnips_expand_or_jump)", true, true, true),
							"m",
							true
						)
						return
					end
					-- Then check if completion menu is visible
					if cmp.is_visible() then
						return cmp.select_next()
					end
					-- Otherwise fallback to default Tab behavior
					return cmp.fallback()
				end,
			}

			-- Custom Shift-Tab handler for UltiSnips integration
			opts.keymap["<S-Tab>"] = {
				function(cmp)
					-- First check if UltiSnips can jump backwards
					if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_backward)", true, true, true),
							"m",
							true
						)
						return
					end
					-- Then check if completion menu is visible
					if cmp.is_visible() then
						return cmp.select_prev()
					end
					-- Otherwise fallback to default Shift-Tab behavior
					return cmp.fallback()
				end,
			}

			return opts
		end,
	},

	


	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
				["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["h"] = "actions.parent",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			use_default_keymaps = true,
			view_options = {
				show_hidden = false,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},
			float = {
				padding = 2,
				max_width = 90,
				max_height = 30,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Oil<cr>",
				desc = "Open parent directory in Oil",
			},
			{
				"<leader>E",
				function()
					require("oil").toggle_float()
				end,
				desc = "Open Oil in floating window",
			},
		},
	},
}
