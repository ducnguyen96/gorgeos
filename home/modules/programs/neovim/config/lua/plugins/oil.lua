return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		view_options = {
			show_hidden = false,
			is_hidden_file = function(name, _)
				local godot_patterns = {
					"%.uid[/]?$", -- .uid files
					"%.import[/]?$", -- .import files
					"^%.godot[/]?$", -- .godot directory
					"^%.mono[/]?$", -- .mono directory
					"godot.*%.tmp$", -- godot temp files
				}
				for _, pat in ipairs(godot_patterns) do
					if name:match(pat) then
						return true
					end
				end
				return false
			end,
		},
	},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
