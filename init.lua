if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

vim.keymap.set("i", "kj", "<Esc>", { noremap = true })
vim.keymap.set("v", "kj", "<Esc>", { noremap = true })
-- Swap up and down arrow keys
vim.keymap.set("n", "<Up>", "<Down>", { noremap = true })
vim.keymap.set("n", "<Down>", "<Up>", { noremap = true })
