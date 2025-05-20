return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})
			opts.commands = {
				all = {
					-- options for the message history that you get with :Noice
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})
			opts.presets.lsp_doc_border = true
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},
	{
		"snacks.nvim",
		opts = {
			scroll = { enabled = false },
			indent = { enabled = false },
		},
		keys = {},
	},
	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},
	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			-- Custom soft pink theme
			local custom_theme = {
				normal = {
					a = { fg = "#000000", bg = "#f8bbd0" }, -- Soft pink background
					b = { fg = "#f8bbd0", bg = "#282828" }, -- Soft pink text on dark gray
					c = { fg = "#ffcdd2", bg = "#282828" }, -- Very light pink text on dark gray
				},
				insert = {
					a = { fg = "#000000", bg = "#f48fb1" }, -- Medium soft pink for insert mode
					b = { fg = "#f48fb1", bg = "#282828" }, -- Medium soft pink text on dark gray
				},
				visual = {
					a = { fg = "#000000", bg = "#e1bee7" }, -- Soft lavender for visual mode
					b = { fg = "#e1bee7", bg = "#282828" }, -- Soft lavender text on dark gray
				},
				replace = {
					a = { fg = "#000000", bg = "#ec407a" }, -- Medium pink for replace mode
					b = { fg = "#ec407a", bg = "#282828" }, -- Medium pink text on dark gray
				},
				command = {
					a = { fg = "#000000", bg = "#f5ccd4" }, -- Very soft pink for command mode
					b = { fg = "#f5ccd4", bg = "#282828" }, -- Very soft pink text on dark gray
				},
				inactive = {
					a = { fg = "#c0c0c0", bg = "#383838" }, -- Gray when inactive
					b = { fg = "#c0c0c0", bg = "#383838" }, -- Gray when inactive
					c = { fg = "#c0c0c0", bg = "#383838" }, -- Gray when inactive
				},
			}
			opts.options = opts.options or {}
			opts.options.theme = custom_theme
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = true,
	},

	


	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {}
			}
		}
	},
}
