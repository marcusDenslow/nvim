return {
	-- Colorschemes
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
	{ "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
	{ "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			tweak_background = {
				normal = "#101010",
				telescope = "#101010",
				menu = "#101010",
				popup = "#101010",
			},
			tweak_highlight = {
				["Normal"] = {
					fg = "#ffffff",
				},
			},
		},
	},
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	{
		"miikanissi/modus-themes.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				-- Optional configuration here
			})
		end,
	},

	-- Colorscheme switcher with live preview
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					"tokyonight-night",
					"tokyonight-storm",
					"tokyonight-moon",
					"tokyonight-day",
					"catppuccin-mocha",
					"catppuccin-macchiato",
					"catppuccin-frappe",
					"catppuccin-latte",
					"kanagawa",
					"kanagawa-dragon",
					"kanagawa-wave",
					"rose-pine",
					"rose-pine-moon",
					"rose-pine-dawn",
					"nightfox",
					"dawnfox",
					"duskfox",
					"nordfox",
					"terafox",
					"carbonfox",
					"gruvbox-material",
					"lackluster",
					"lackluster-hack",
					"lackluster-mint",
					"moonfly",
					"modus_operandi",
					"modus_vivendi",
				},
				livePreview = true, -- Live preview of colorscheme changes
			})

			-- Keybinding to open themery
			vim.keymap.set("n", "<leader>ft", "<cmd>Themery<cr>", { desc = "Change colorscheme (theme)" })
		end,
	},
}
