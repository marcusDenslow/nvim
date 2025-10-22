return {
	{
		"sho-87/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- Load colorscheme
			vim.cmd("colorscheme kanagawa-paper")
		end,
	},
}
