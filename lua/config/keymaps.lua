local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Buffer navigation with Shift+H and Shift+L
keymap.set("n", "H", ":bprevious<Return>", opts)
keymap.set("n", "L", ":bnext<Return>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Switch between windows with leader + hjkl
keymap.set("n", "<Leader>h", "<C-w>h", opts)
keymap.set("n", "<Leader>j", "<C-w>j", opts)
keymap.set("n", "<Leader>k", "<C-w>k", opts)
keymap.set("n", "<Leader>l", "<C-w>l", opts)

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- Removed broken craftzdog.hsl keybind

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
	require("craftzdog.lsp").toggleAutoformat()
end, {})

-- Custom bracket navigation
keymap.set("n", "<C-h>", "{", opts)
keymap.set("n", "<C-j>", "[", opts)
keymap.set("n", "<C-k>", "]", opts)
keymap.set("n", "<C-l>", "}", opts)
keymap.set("v", "<C-h>", "{", opts)
keymap.set("v", "<C-j>", "[", opts)
keymap.set("v", "<C-k>", "]", opts)
keymap.set("v", "<C-l>", "}", opts)
keymap.set("i", "<C-h>", function()
	vim.api.nvim_feedkeys("{}", "n", false)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", false)
end, opts)
keymap.set("i", "<C-j>", function()
	vim.api.nvim_feedkeys("[]", "n", false)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", false)
end, opts)
keymap.set("i", "<C-k>", function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local next_char = line:sub(col + 1, col + 1)
	if next_char == "]" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
	else
		vim.api.nvim_feedkeys("]", "n", false)
	end
end, opts)
keymap.set("i", "<C-l>", function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local next_char = line:sub(col + 1, col + 1)
	if next_char == "}" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
	else
		vim.api.nvim_feedkeys("}", "n", false)
	end
end, opts)

-- Fix last spelling mistake
keymap.set("n", "<leader>sf", function()
	-- Save current position
	local pos = vim.api.nvim_win_get_cursor(0)
	-- Go to previous misspelled word
	vim.cmd("normal! [s")
	-- Fix with first suggestion
	vim.cmd("normal! 1z=")
	-- Return to original position (adjusted for any text changes)
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Fix last spelling mistake", noremap = true, silent = true })

-- Toggle spell checking
keymap.set("n", "<leader>ts", function()
	vim.opt.spell = not vim.opt.spell:get()
	if vim.opt.spell:get() then
		print("Spell checking enabled")
	else
		print("Spell checking disabled")
	end
end, { desc = "Toggle spell checking", noremap = true, silent = true })

-- Toggle blink.cmp completion
keymap.set("n", "<leader>tc", function()
	-- Initialize if needed
	if vim.g.blink_cmp_enabled == nil then
		vim.g.blink_cmp_enabled = true
	end

	-- Toggle the state
	vim.g.blink_cmp_enabled = not vim.g.blink_cmp_enabled

	-- Try to hide any visible menu
	local ok, blink = pcall(require, "blink.cmp")
	if ok and blink.is_visible and blink.is_visible() then
		blink.hide()
	end

	-- Print status
	if vim.g.blink_cmp_enabled then
		print("Blink.cmp enabled")
	else
		print("Blink.cmp disabled")
	end
end, { desc = "Toggle blink.cmp completion", noremap = true, silent = true })
