if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

vim.g.loaded_matchparen = 1
vim.opt.showmatch = false
require("config.lazy")

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("v", "jj", "<Esc>", { noremap = true })
-- Swap up and down arrow keys
vim.keymap.set("n", "<Up>", "<Down>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Up>", { noremap = true })

vim.cmd([[colorscheme modus]])
