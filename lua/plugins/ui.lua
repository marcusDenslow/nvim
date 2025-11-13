return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Which-key for keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			-- Register leader key groups
			wk.add({
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Spell" },
				{ "<leader>t", group = "Toggle" },
				{ "<leader>c", group = "Code" },
				{ "<leader>r", group = "Rename" },
			})
		end,
	},

	-- Alpha.nvim - Splash screen
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			return dashboard.config
		end,
		config = function(_, dashboard)
			require("alpha").setup(dashboard)
		end,
	},
}
