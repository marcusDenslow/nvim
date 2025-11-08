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
				build_dir = "../pdfs",
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

			-- Auto-commit and push tex-notes on successful compilation
			vim.api.nvim_create_autocmd("User", {
				pattern = "VimtexEventCompileSuccess",
				callback = function()
					local tex_notes_dir = vim.fn.expand("$HOME/Documents/tex-notes")
					local current_file = vim.fn.expand("%:p")

					-- Check if current file is in tex-notes directory
					if string.find(current_file, tex_notes_dir, 1, true) then
						-- Run git commands asynchronously
						vim.fn.jobstart({
							"sh",
							"-c",
							string.format(
								[[
								cd "%s" && \
								git add . && \
								git commit -m "Auto-update: $(date '+%%Y-%%m-%%d %%H:%%M:%%S')" && \
								git push
								]],
								tex_notes_dir
							)
						}, {
							on_exit = function(_, exit_code)
								if exit_code == 0 then
									vim.notify("✓ LaTeX notes pushed to GitHub", vim.log.levels.INFO)
								else
									-- Silently fail if no changes (exit code 1 from git commit)
									-- Only notify on actual errors
									if exit_code ~= 1 then
										vim.notify("✗ Failed to push notes (exit code: " .. exit_code .. ")", vim.log.levels.WARN)
									end
								end
							end,
							stdout_buffered = true,
							stderr_buffered = true,
						})
					end
				end,
			})
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
