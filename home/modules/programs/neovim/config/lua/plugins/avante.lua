return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	opts = {
		behaviour = {
			auto_suggestions = true,
			auto_set_keymaps = false,
		},
		provider = "nineRouter",
		auto_suggestions_provider = "nineRouter",
		providers = {
			openrouter = {
				__inherited_from = "openai",

				endpoint = "https://openrouter.ai/api/v1",
				api_key_name = "OPENROUTER_API_KEY",

				model = "openrouter/free",
			},
			nineRouter = {
				__inherited_from = "openai",

				endpoint = "http://localhost:20128/v1",
				api_key_name = "NINEROUTER_API_KEY",
			},
		},
	},
	cmd = {
		"AvanteAsk",
		"AvanteBuild",
		"AvanteChat",
		"AvanteClear",
		"AvanteEdit",
		"AvanteFocus",
		"AvanteHistory",
		"AvanteModels",
		"AvanteRefresh",
		"AvanteShowRepoMap",
		"AvanteStop",
		"AvanteSwitchProvider",
		"AvanteToggle",
	},
	keys = {
		{ "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
		{ "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
		{ "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
		{ "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
		{ "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
		{ "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
		{ "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
		{ "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
		{ "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
		{ "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
		{ "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante" },
	},
}
