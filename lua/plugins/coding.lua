return {
	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

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

	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
		},
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
