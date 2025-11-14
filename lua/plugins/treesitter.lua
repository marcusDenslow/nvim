return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"astro",
				"cmake",
				"cpp",
				"c",
				"css",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"php",
				"python",
				"rust",
				"scss",
				"sql",
				"svelte",
			},
			highlight = {
				enable = true,
				disable = { "latex", "tex" },
			},
			indent = {
				enable = true,
			},
			auto_install = true,
		ignore_install = { "latex", "tex" },
		},
	},
}
