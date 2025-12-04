return {
	{
		"rmagatti/goto-preview",
		event = "LspAttach",
		config = function()
			require("goto-preview").setup({
				width = 120,
				height = 20,
				border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				default_mappings = false,
				focus_on_open = true,
				dismiss_on_move = false,
				opacity = nil,
				post_open_hook = function(buf, win)
					-- When in preview window, press <CR> to jump to the actual file
					vim.keymap.set("n", "<CR>", function()
						-- Get the current position in the preview
						local pos = vim.api.nvim_win_get_cursor(win)
						local file = vim.api.nvim_buf_get_name(buf)

						-- Close preview
						require("goto-preview").close_all_win()

						-- Jump to the file
						vim.cmd("edit " .. vim.fn.fnameescape(file))
						vim.api.nvim_win_set_cursor(0, pos)
					end, { buffer = buf, noremap = true, silent = true })
				end,
			})
		end,
	},
}
