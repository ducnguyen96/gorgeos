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
						config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
					else
						config.settings.python.pythonPath = tostring(venv:joinpath("Scripts", "python.exe"))
					end
				end,
			},
		},
	},
}
