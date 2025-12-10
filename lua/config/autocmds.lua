-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Force syntax highlighting and treesitter for all buffers
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		-- Force syntax on
		vim.cmd("syntax enable")
		-- Force filetype detection
		vim.cmd("filetype detect")
		-- Start treesitter if available
		vim.defer_fn(function()
			pcall(vim.treesitter.start, buf)
		end, 100)
	end,
})

-- Light purple matching bracket/parentheses highlighting
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MatchParen", {
			fg = "#000000", -- Black text
			bg = "#B4A7D6", -- Light purple background block
			bold = true,
		})
	end,
})

-- Apply the highlight immediately on startup
vim.api.nvim_set_hl(0, "MatchParen", {
	fg = "#000000", -- Black text
	bg = "#B4A7D6", -- Light purple background block
	bold = true,
})
