return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = { mason = false },
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {},
		},
	},
}
