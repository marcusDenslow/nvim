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

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Function to set visible end-of-buffer tildes
local function set_visible_eob()
	vim.opt.fillchars:append({ eob = "~" })

	-- Get background color to determine if we're in a light or dark theme
	local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" })
	local is_dark = vim.o.background == "dark"

	-- Choose a visible color based on background and make it bold
	local eob_color = is_dark and "#666666" or "#aaaaaa"
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = eob_color, bold = true })
end

-- Ensure end-of-buffer tildes are visible after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.schedule(set_visible_eob)
	end,
})

-- Also apply on VimEnter to ensure it's set after all plugins load
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.schedule(set_visible_eob)
	end,
})
