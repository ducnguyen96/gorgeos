return {
	"yetone/avante.nvim",
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
				model = "qwen2.5-coder:1.5b",
			},
		},
		selection = {
			hint_display = true,
		},
		behaviour = {
			auto_set_keymaps = false,
		},
	},
}
