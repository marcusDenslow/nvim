if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"

vim.keymap.set("i", "kj", "<Esc>", { noremap = true })
vim.keymap.set("v", "kj", "<Esc>", { noremap = true })
-- Swap up and down arrow keys
vim.keymap.set("n", "<Up>", "<Down>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Up>", { noremap = true })

-- Set custom background color for all UI elements
-- vim.api.nvim_create_autocmd("UIEnter", {
-- 	callback = function()
-- 		vim.cmd([[
--       augroup CustomBackground
--         autocmd!
--         autocmd VimEnter,ColorScheme * highlight Normal guibg=#282828 ctermbg=236
--         autocmd VimEnter,ColorScheme * highlight NormalFloat guibg=#282828 ctermbg=236
--         autocmd VimEnter,ColorScheme * highlight NormalNC guibg=#282828 ctermbg=236
--       augroup END
--     ]])
-- 
-- 		-- Set background immediately
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#282828" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "#282828" })
-- 	end,
-- 	once = true,
-- })
