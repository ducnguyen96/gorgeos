return {
	"neovim/nvim-lspconfig",
	---@class PluginLspOpts
	opts = {
		---@type lspconfig.options
		servers = {
			-- pyright will be automatically installed with mason and loaded with lspconfig
			pyright = {
				before_init = function(params, config)
					local Path = require("plenary.path")

					local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")

					if venv:joinpath("bin"):is_dir() then
						-- Local Poetry environment
						config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
					else
						-- Fallback to system Python
						config.settings.python.pythonPath = vim.fn.exepath("python3")
							or vim.fn.exepath("python")
							or "python"
					end
				end,
			},
		},
	},
}
