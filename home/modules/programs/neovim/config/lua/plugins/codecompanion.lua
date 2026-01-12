return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves UI
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				-- Use Ollama for both chat and inline transformations
				chat = {
					adapter = "ollama",
				},
				inline = {
					adapter = "ollama",
				},
			},
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = "qwen2.5-coder:0.5b",
							},
							num_ctx = {
								default = 32768, -- Higher context window for better code understanding
							},
						},
					})
				end,
			},
		})
	end,
	keys = {
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to AI Chat" },
	},
}
