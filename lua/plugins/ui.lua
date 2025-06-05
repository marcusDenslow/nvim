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
		enabled = false,
	},
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			-- Catppuccin Frappe theme with pure black background
			local catppuccin_colors = {
				rosewater = "#F2D5CF",
				flamingo = "#EEBEBE",
				pink = "#F4B8E4",
				mauve = "#CA9EE6",
				red = "#E78284",
				maroon = "#EA999C",
				peach = "#EF9F76",
				yellow = "#E5C890",
				green = "#A6D189",
				teal = "#81C8BE",
				sky = "#99D1DB",
				sapphire = "#85C1DC",
				blue = "#8CAAEE",
				lavender = "#BABBF1",
				text = "#C6D0F5",
				subtext1 = "#B5BFE2",
				subtext0 = "#A5ADCE",
				overlay2 = "#949CBB",
				overlay1 = "#838BA7",
				overlay0 = "#737994",
				surface2 = "#626880",
				surface1 = "#51576D",
				surface0 = "#414559",
				base = "#000000", -- Changed to pure black
				mantle = "#000000", -- Changed to pure black
				crust = "#000000", -- Changed to pure black
			}

			local catppuccin_frappe = {
				normal = {
					a = { fg = catppuccin_colors.base, bg = catppuccin_colors.blue },
					b = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
					c = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
				},
				insert = {
					a = { fg = catppuccin_colors.base, bg = catppuccin_colors.green },
					b = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
				},
				visual = {
					a = { fg = catppuccin_colors.base, bg = catppuccin_colors.mauve },
					b = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
				},
				replace = {
					a = { fg = catppuccin_colors.base, bg = catppuccin_colors.red },
					b = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
				},
				command = {
					a = { fg = catppuccin_colors.base, bg = catppuccin_colors.peach },
					b = { fg = catppuccin_colors.text, bg = catppuccin_colors.base },
				},
				inactive = {
					a = { fg = catppuccin_colors.overlay0, bg = catppuccin_colors.base },
					b = { fg = catppuccin_colors.overlay0, bg = catppuccin_colors.base },
					c = { fg = catppuccin_colors.overlay0, bg = catppuccin_colors.base },
				},
			}
			
			opts.options = opts.options or {}
			opts.options.theme = catppuccin_frappe
			-- Custom sections: mode + branch + diagnostics on left
			opts.sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { "diagnostics" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
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
