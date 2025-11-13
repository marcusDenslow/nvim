return {
	-- Incremental rename


	-- Surround text objects with brackets, quotes, tags, etc.
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},

	-- Better text objects (a/i + additional targets)
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup()
		end,
	},


	-- Tabout plugin - tab out of brackets, quotes, etc.
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			tabkey = "<Tab>",
			backwards_tabkey = "<S-Tab>",
			act_as_tab = true,
			act_as_shift_tab = false,
			default_tab = "<C-t>",
			default_shift_tab = "<C-d>",
			enable_backwards = true,
			completion = true,
			tabouts = {
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
			},
			ignore_beginning = true,
			exclude = {},
		},
	},
}
