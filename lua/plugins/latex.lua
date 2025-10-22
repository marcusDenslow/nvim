return {
	-- Disable autopairs for LaTeX to let UltiSnips handle delimiters
	{
		"windwp/nvim-autopairs",
		optional = true,
		opts = {
			disable_filetype = { "tex", "latex" },
		},
	},

	-- VimTeX: LaTeX plugin for Vim/Neovim
	{
		"lervag/vimtex",
		lazy = false, -- Don't lazy load VimTeX
		-- tag = "v2.15", -- Uncomment to pin to specific release
		init = function()
			-- Viewer configuration
			vim.g.vimtex_view_method = "zathura"

			-- Compiler settings
			vim.g.vimtex_compiler_method = "latexmk"

			-- Quickfix settings
			vim.g.vimtex_quickfix_mode = 2 -- Open quickfix but don't steal focus
			vim.g.vimtex_quickfix_open_on_warning = 0 -- Don't open for warnings

			-- PDF viewer settings for forward search
			vim.g.vimtex_view_general_viewer = "zathura"

			-- Disable some features for faster startup
			vim.g.vimtex_indent_enabled = 1
			vim.g.vimtex_syntax_enabled = 1

			-- Fold settings (disabled by default for better performance)
			vim.g.vimtex_fold_enabled = 0

			-- Concealment settings (enabled)
			vim.g.vimtex_syntax_conceal_disable = 0
			vim.opt.conceallevel = 2 -- Hide concealed text completely when cursor not on line
			vim.opt.concealcursor = "" -- Show concealed text when cursor on line

			-- Improved syntax highlighting
			vim.g.vimtex_syntax_packages = {
				minted = { load = 2 },
			}

			-- Enable more complete completion
			vim.g.vimtex_complete_enabled = 1
			vim.g.vimtex_complete_close_braces = 1

			-- Compiler options
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "",
				callback = 1,
				continuous = 1, -- Auto-recompile on save
				executable = "latexmk",
				hooks = {},
				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
		end,
	},

	-- UltiSnips - Gilles Castel's original snippet engine
	{
		"SirVer/ultisnips",
		dependencies = { "lervag/vimtex" },
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
			vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
			vim.g.UltiSnipsSnippetDirectories = { "UltiSnips" }
			vim.g.UltiSnipsEnableSnipMate = 0

			-- Ensure select mode works properly for placeholder replacement
			vim.cmd([[
				" Make sure typing in select mode replaces the selection
				snoremap <silent> <BS> <C-g>"_c

				" Set proper select mode options
				set selection=exclusive
				set selectmode=mouse,key
				set keymodel=startsel,stopsel
			]])
		end,
		ft = "tex", -- Only load for LaTeX files
	},
}
