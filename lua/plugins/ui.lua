return {
	-- Tiny inline diagnostic - Better looking inline diagnostics
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		opts = {},
	},

	-- Which-key for keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			-- Register leader key groups
			wk.add({
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Spell" },
				{ "<leader>t", group = "Toggle" },
				{ "<leader>c", group = "Code" },
				{ "<leader>r", group = "Rename" },
			})
		end,
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
		},
		init = function()
			-- Fix syntax highlighting after session restore
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistenceLoadPost",
				callback = function()
					vim.cmd("doautocmd BufRead")
				end,
			})
		end,
	},

	-- Alpha.nvim - Splash screen
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")

			-- Custom header
			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ██╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗  ██║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔██╗ ██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╗██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚████║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═══╝ ",
				"                                                     ",
			}

			-- Custom buttons
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", "<cmd>FzfLua files<CR>"),
				dashboard.button("n", "  New file", "<cmd>ene <BAR> startinsert<CR>"),
				dashboard.button("r", "  Recent files", "<cmd>FzfLua oldfiles<CR>"),
				dashboard.button("g", "  Find text", "<cmd>FzfLua live_grep<CR>"),
				dashboard.button("s", "  Restore Session", "<cmd>lua require('persistence').load()<CR>"),
				dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
			}

			-- Set highlight groups for buttons
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.footer.opts.hl = "AlphaFooter"

			dashboard.opts.layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

			return dashboard
		end,
		config = function(_, dashboard)
			-- Close lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
