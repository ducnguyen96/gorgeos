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
}
