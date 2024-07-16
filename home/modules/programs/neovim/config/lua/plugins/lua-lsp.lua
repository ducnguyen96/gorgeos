return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				lua_ls = { mason = false },
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
