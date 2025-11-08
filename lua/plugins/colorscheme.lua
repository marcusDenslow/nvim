return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")

			-- Override background to match Ghostty (#101010)
			vim.api.nvim_set_hl(0, "Normal", { bg = "#101010" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#101010" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "#101010" })

			-- Set colorcolumn to light gray
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3a3a3a" })
		end,
	},
}
