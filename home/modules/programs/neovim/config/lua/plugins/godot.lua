return {
	"Mathijs-Bakker/godotdev.nvim",
	dependencies = { "nvim-dap", "nvim-dap-ui", "nvim-treesitter" },
	config = function()
		require("godotdev").setup({
			editor_host = "127.0.0.1", -- Godot editor host
			editor_port = 6005, -- Godot LSP port
			debug_port = 6006, -- Godot debugger port
			csharp = true, -- Enable C# Installation Support
			autostart_editor_server = false, -- opt-in: start a Neovim server automatically on setup
			formatter = "gdscript-formatter", -- "gdscript-formatter" | "gdformat" | false
			formatter_cmd = nil, -- string or argv list; default gdscript-formatter adds "--reorder-code"
			inline_hints = {
				enabled = false, -- enable Neovim inlay hints when the attached server supports them
			},
			run = {
				console = {
					enabled = false, -- capture :GodotRun* output in Neovim; these runs are no longer detached
					renderer = "buffer", -- "buffer" | "float"
					buffer = {
						position = "bottom", -- "right" | "bottom" | "current"
						size = 0.3,
					},
					float = {
						width = 0.8,
						height = 0.25,
						border = "rounded",
					},
				},
			},
			scene_tree = {
				buffer = {
					position = "left", -- "left" | "right"
					size = 0.35,
				},
				icons = "nerdfont", -- "nerdfont" | "ascii" | false | { generic = "...", script_suffix = "...", types = { Node2D = "..." } }
				icon_colors = {
					generic = { fg = "white" },
					groups = {
						White = { fg = "white" },
						Grey = { fg = "grey" },
						Blue = { fg = "blue" },
						Red = { fg = "red" },
						Green = { fg = "green" },
						Purple = { fg = "magenta" },
						Yellow = { fg = "gold" },
					},
				},
			},
			editor_server = {
				address = nil, -- nil uses the current server or the platform default
				remove_stale_socket = true,
			},
			treesitter = {
				auto_setup = true, -- convenience default; disable if you manage nvim-treesitter yourself
				ensure_installed = { "gdscript" },
			},
			docs = {
				renderer = "float", -- default: open docs in a floating window
				fallback_renderer = "browser", -- nil | "browser" | "buffer"; browser is the only fetch-recovery fallback
				missing_symbol_feedback = "message", -- "message" | "notify"
				version = "stable", -- e.g. "stable", "latest", "4.5"
				language = "en",
				source_ref = "master", -- godot-docs git ref used for floating docs
				source_base_url = nil, -- optional override for raw docs source
				timeout_ms = 10000,
				cache = {
					enabled = true,
					max_entries = 64,
				},
				float = {
					width = 0.8,
					height = 0.8,
					border = "rounded",
				},
				buffer = {
					position = "right", -- "right" | "bottom" | "current"
					size = 0.4,
				},
			},
		})
	end,
}
