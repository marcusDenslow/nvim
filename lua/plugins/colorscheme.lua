return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					Normal = { bg = "#000000" },
					NormalNC = { bg = "#000000" },
					NormalFloat = { bg = "#000000" },
					NormalSB = { bg = "#000000" },
					SignColumn = { bg = "#000000" },
					LineNr = { bg = "#000000" },
					LineNrAbove = { bg = "#000000" },
					LineNrBelow = { bg = "#000000" },
					CursorLineNr = { bg = "#000000" },
					EndOfBuffer = { bg = "#000000" },
					Folded = { bg = "#000000" },
					FoldColumn = { bg = "#000000" },
					NonText = { bg = "#000000" },
					CursorLine = { bg = "#000000" },
					ColorColumn = { bg = "#000000" },
					StatusLine = { bg = "#000000" },
					StatusLineNC = { bg = "#000000" },
					TabLine = { bg = "#000000" },
					TabLineFill = { bg = "#000000" },
					TabLineSel = { bg = "#000000" },
					WinBar = { bg = "#000000" },
					WinBarNC = { bg = "#000000" },
					VertSplit = { bg = "#000000" },
					WinSeparator = { bg = "#000000" },
					MsgArea = { bg = "#000000" },
					MsgSeparator = { bg = "#000000" },
					FloatBorder = { bg = "#000000" },
					FloatTitle = { bg = "#000000" },
					Pmenu = { bg = "#000000" },
					PmenuSbar = { bg = "#000000" },
					PmenuThumb = { bg = "#000000" },
				},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.cmd("colorscheme gruvbox")
			-- Force black background after everything loads with 10ms delay
			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
				vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
			end, 10)
			-- Improved autocmd that handles all buffer events and ensures colorscheme consistency
			vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme", "BufEnter", "BufRead", "BufNewFile" }, {
				callback = function()
					-- Force colorscheme first if it's not gruvbox
					if vim.g.colors_name ~= "gruvbox" then
						vim.cmd("colorscheme gruvbox")
					end
					-- Then set custom highlights
					vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
					vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
				end,
			})
		end,
	},
}
