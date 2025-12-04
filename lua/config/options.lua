vim.g.mapleader = " "

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"  -- Always show sign column for breakpoints
-- vim.opt.colorcolumn = "80"

-- vim.opt.numberspace = 3
vim.opt.numberwidth = 6
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.expandtab = false
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""
vim.opt.list = false
vim.opt.fillchars:append({ eob = "~" }) -- Show ~ on empty lines like default vim

-- Spell checking (disabled by default, toggle with <leader>ts)
vim.opt.spell = false
vim.opt.spelllang = "en_us" -- English (US)

vim.opt.syntax = "on"
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250"
vim.opt.cursorline = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

-- if vim.fn.has("nvim-0.8") == 1 then
-- 	vim.opt.cmdheight = 1
-- end

-- File types
vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

-- Disable virtual_text immediately to prevent conflicts with tiny-inline-diagnostic
vim.diagnostic.config({
	virtual_text = false,
})

-- Suppress deprecation warnings from plugins
vim.deprecate = function() end
