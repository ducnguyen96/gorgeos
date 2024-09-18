return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = { mason = false },
			},
			inlay_hints = {
				enabled = false,
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {},
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		opts = {
			-- add your options that should be passed to the setup() function here
			position = "right",
		},
	},
}
