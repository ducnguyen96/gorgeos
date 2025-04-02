return {
	"nvim-neorg/neorg",
	dependencies = { "hrsh7th/nvim-cmp" },
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.summary"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.nvim-cmp"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							default = "~/Documents/notes", -- Format: <name_of_workspace> = <path_to_workspace_root>
						},
						default_workspace = "default",
						index = "index.norg", -- The name of the main (root) .norg file
					},
				},
			},
		})
	end,
}
