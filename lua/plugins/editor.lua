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
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			-- File search
			{ "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
			{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Find word under cursor" },
			{ "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
			{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },

			-- Git
			{ "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
			{ "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git status" },

			-- LSP
			{ "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },

			-- Resume last picker
			{ "<leader>f.", "<cmd>FzfLua resume<cr>", desc = "Resume last picker" },
		},
		opts = {
			winopts = {
				border = "none",
				backdrop = 100,
				preview = {
					border = "noborder",
					title = false,
					scrollbar = false,
					hidden = "nohidden",
				},
			},
			fzf_colors = true,
			files = {
				-- Include hidden files
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
				file_icons = false,
				git_icons = false,
			},
			grep = {
				-- Include hidden files in grep
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/*'",
				file_icons = false,
				git_icons = false,
			},
			lsp = {
				file_icons = false,
				git_icons = false,
			},
			git = {
				file_icons = false,
				git_icons = false,
			},
		},
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
			opts.completion.menu.max_height = 20
			opts.completion.menu.draw = opts.completion.menu.draw or {}
			opts.completion.menu.draw.columns = {
				{ "kind_icon" },
				{ "label", "label_description", gap = 1 },
			}

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
					if
						vim.fn.exists("*UltiSnips#CanExpandSnippet") == 1
						and (vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1)
					then
						vim.schedule(function()
							vim.fn["UltiSnips#ExpandSnippetOrJump"]()
						end)
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
					if
						vim.fn.exists("*UltiSnips#CanJumpBackwards") == 1
						and vim.fn["UltiSnips#CanJumpBackwards"]() == 1
					then
						vim.schedule(function()
							vim.fn["UltiSnips#JumpBackwards"]()
						end)
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
		opts = {
			modes = {
				char = {
					enabled = true,
					keys = { "f", "F", "t", "T" },
				},
			},
		},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
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
				["<C-s>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-h>"] = {
					"actions.select",
					opts = { horizontal = true },
					desc = "Open the entry in a horizontal split",
				},
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

	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		ft = { "rust" },
		init = function()
			-- Configure codelldb path before rustaceanvim loads
			local codelldb_path = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb")
			local liblldb_path = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so")

			vim.g.rustaceanvim = {
				dap = {
					adapter = {
						type = "server",
						port = "${port}",
						executable = {
							command = codelldb_path,
							args = { "--port", "${port}" },
						},
					},
				},
			}
		end,
		opts = {
			server = {
				on_attach = function(client, bufnr)
					-- Custom keymaps for Rust
					vim.keymap.set("n", "<leader>ca", function()
						vim.cmd.RustLsp("codeAction")
					end, { buffer = bufnr, desc = "Code Action" })
					vim.keymap.set("n", "<leader>md", function()
						vim.cmd.RustLsp("debuggables")
					end, { buffer = bufnr, desc = "Rust Debuggables" })
					vim.keymap.set("n", "<leader>mt", function()
						vim.cmd.RustLsp("testables")
					end, { buffer = bufnr, desc = "Rust Testables" })
					vim.keymap.set("n", "<leader>mT", function()
						vim.cmd.RustLsp({ "testables", bang = true })
					end, { buffer = bufnr, desc = "Rerun Last Test" })
				end,
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
							sysroot = "discover",
							-- Don't try to build stdlib, just use it for navigation
							sysrootSrc = "/usr/lib/rustlib/src/rust/library",
						},
						rustfmt = {
							extraArgs = { "+stable" },
						},
						check = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
							allTargets = false,
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						-- This is the key setting for auto-importing crates
						completion = {
							autoimport = {
								enable = true,
							},
							autoself = {
								enable = true,
							},
							postfix = {
								enable = true,
							},
						},
						-- Import settings
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						inlayHints = {
							bindingModeHints = {
								enable = false,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = {
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							reborrowHints = {
								enable = "never",
							},
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
	},
}
