function ColorMyPencils(color)
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)
end

return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				palette_overrides = {},
				overrides = {
					Normal = { bg = "#FFFFFF" }, -- White background
					NormalFloat = { bg = "#FFFFFF" }, -- White background for floating windows
				}
			})
			vim.cmd("colorscheme gruvbox")
			ColorMyPencils()
		end,
	},
}