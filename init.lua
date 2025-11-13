if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

-- Load configuration
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"
vim.opt.swapfile = false

vim.keymap.set("i", "kj", "<Esc>", { noremap = true })
vim.keymap.set("v", "kj", "<Esc>", { noremap = true })
