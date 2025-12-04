return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				zig = { "zigfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},
			-- Format on save (optional - remove if you don't want this)
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			-- Set up formatexpr to use conform for = commands
			formatters = {},
		},
		init = function()
			-- Set formatexpr to use conform for = operator
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
