return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		enabled = false,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},
	-- {
	-- "snacks.nvim",
	-- opts = {
	-- scroll = { enabled = false },
	-- indent = { enabled = false },
	-- },
	-- keys = {},
	-- },
	-- buffer line
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	-- filename
	{
		"b0o/incline.nvim",
		enabled = false,
	},
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
	},
	-- {
	-- opts = function(_, opts)
	-- local LazyVim = require("lazyvim.util")
	-- -- Gruvbox colors
	-- local gruvbox_colors = {
	-- bg0 = "#282828",
	-- bg1 = "#3c3836",
	-- bg2 = "#504945",
	-- bg3 = "#665c54",
	-- bg4 = "#7c6f64",
	-- fg0 = "#fbf1c7",
	-- fg1 = "#ebdbb2",
	-- fg2 = "#d5c4a1",
	-- fg3 = "#bdae93",
	-- fg4 = "#a89984",
	-- red = "#fb4934",
	-- green = "#b8bb26",
	-- yellow = "#fabd2f",
	-- blue = "#83a598",
	-- purple = "#d3869b",
	-- aqua = "#8ec07c",
	-- orange = "#fe8019",
	-- }

	-- local gruvbox_theme = {
	-- normal = {
	-- a = { fg = gruvbox_colors.bg0, bg = gruvbox_colors.yellow },
	-- b = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg1 },
	-- c = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg0 },
	-- },
	-- insert = {
	-- a = { fg = gruvbox_colors.bg0, bg = gruvbox_colors.yellow },
	-- b = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg1 },
	-- },
	-- visual = {
	-- a = { fg = gruvbox_colors.bg0, bg = gruvbox_colors.yellow },
	-- b = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg1 },
	-- },
	-- replace = {
	-- a = { fg = gruvbox_colors.bg0, bg = gruvbox_colors.yellow },
	-- b = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg1 },
	-- },
	-- command = {
	-- a = { fg = gruvbox_colors.bg0, bg = gruvbox_colors.yellow },
	-- b = { fg = gruvbox_colors.fg1, bg = gruvbox_colors.bg1 },
	-- },
	-- inactive = {
	-- a = { fg = gruvbox_colors.fg4, bg = gruvbox_colors.bg0 },
	-- b = { fg = gruvbox_colors.fg4, bg = gruvbox_colors.bg0 },
	-- c = { fg = gruvbox_colors.fg4, bg = gruvbox_colors.bg0 },
	-- },
	-- }

	-- opts.options = opts.options or {}
	-- opts.options.theme = gruvbox_theme
	-- -- Custom sections: mode + branch + diagnostics on left
	-- opts.sections = {
	-- lualine_a = { "mode" },
	-- lualine_b = { "branch" },
	-- lualine_c = { "diagnostics" },
	-- lualine_x = {},
	-- lualine_y = {},
	-- lualine_z = {},
	-- }
	-- end,
	-- },
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
				preset = {},
			},
			statuscolumn = { enabled = false },
			indent = { enabled = false },
			animate = { enabled = false },
			scroll = { enabled = false },
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
