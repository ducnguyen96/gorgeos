return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			nix = { "alejandra" },

			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			less = { "prettier" },
			scss = { "prettier" },
			typescript = { "prettier" },
			tsx = { "prettier" },
			jsx = { "prettier" },
		},
	},
}
