return {
	-- fidget.nvim - LSP progress UI
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-- tools
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				-- LSP servers
				"clangd",
				-- rust-analyzer handled by rustaceanvim
				"pyright",
				-- Formatters
				"stylua",
				"black",
				"isort",
				"prettier",
				"clang-format",
			},
		},
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- Setup LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Key mappings
					local opts = { buffer = ev.buf, silent = true }
					vim.keymap.set("n", "gd", function()
						require("goto-preview").goto_preview_definition()
					end, opts)
					vim.keymap.set("n", "gp", function()
						require("goto-preview").close_all_win()
					end, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				end,
			})

			-- Configure clangd using new API
			vim.lsp.config.clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
				capabilities = {},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			}

			-- Configure zls (Zig)
			vim.lsp.config.zls = {
				cmd = { "zls" },
				filetypes = { "zig", "zir" },
				root_markers = { "zls.json", "build.zig", ".git" },
			}

			-- rust-analyzer is handled by rustaceanvim plugin

			-- Configure lua_ls
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				single_file_support = true,
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							workspaceWord = true,
							callSnippet = "Both",
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
						diagnostics = {
							disable = { "incomplete-signature-doc", "trailing-space" },
							globals = { "vim" },
							unusedLocalExclude = { "_*" },
						},
						format = {
							enable = false,
						},
					},
				},
			}

			-- Configure pyright (Python)
			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					".git",
				},
				single_file_support = true,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			}

			-- Enable LSP servers for the appropriate filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				callback = function()
					vim.lsp.enable("clangd")
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "zig", "zir" },
				callback = function()
					vim.lsp.enable("zls")
				end,
			})

			-- Rust FileType handled by rustaceanvim

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "lua",
				callback = function()
					vim.lsp.enable("lua_ls")
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function()
					vim.lsp.enable("pyright")
				end,
			})
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				-- rust_analyzer handled by rustaceanvim
				"zls",
				"pyright",
			},
		},
	},
}
