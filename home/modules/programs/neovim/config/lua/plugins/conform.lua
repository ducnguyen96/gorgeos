return {
	"stevearc/conform.nvim",
	opts = {
		-- LazyVim will use these options when formatting with the conform.nvim formatter
		default_format_opts = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
		},
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
		formatters = {
			injected = { options = { ignore_errors = true } },
			-- # Example of using dprint only when a dprint.json file is present
			-- dprint = {
			--   condition = function(ctx)
			--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
			--   end,
			-- },
			--
			-- # Example of using shfmt with extra args
			-- shfmt = {
			--   prepend_args = { "-i", "2", "-ci" },
			-- },
		},
	},
}
