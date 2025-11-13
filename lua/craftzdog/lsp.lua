local M = {}

-- Global variable to track autoformat state
vim.g.autoformat_enabled = true

function M.toggleInlayHints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

function M.toggleAutoformat()
	vim.g.autoformat_enabled = not vim.g.autoformat_enabled
	if vim.g.autoformat_enabled then
		print("Autoformat enabled")
	else
		print("Autoformat disabled")
	end
end

return M
