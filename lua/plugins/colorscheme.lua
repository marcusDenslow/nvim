function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = {
			variant = "auto",
			dark_variant = "main",
			disable_background = true,
			disable_float_background = true,
			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
			ColorMyPencils()
		end,
	},
}
