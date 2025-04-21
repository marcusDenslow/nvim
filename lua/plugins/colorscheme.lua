function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({ disable_background = true })

			vim.cmd("colorscheme rose-pine")
			ColorMyPencils()
		end,
	},
}
