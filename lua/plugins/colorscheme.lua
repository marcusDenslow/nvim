return {
	{
		'f4z3r/gruvbox-material.nvim',
		name = 'gruvbox-material',
		lazy = false,
		priority = 1000,
		opts = {
			contrast = "hard",
		},
		config = function()
			require('gruvbox-material').setup({
				contrast = "hard",
			})
			vim.cmd("colorscheme gruvbox-material")
			
			-- Force black background everywhere
			vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#000000" })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "#000000" })
		end,
	},
}
