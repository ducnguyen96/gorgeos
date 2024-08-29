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
					local Job = require("plenary.job")

					local venv = Path:new((config.root_dir:gsub("/", Path.path.sep)), ".venv")
					local flake_file = Path:new(config.root_dir, "flake.nix")

					if venv:joinpath("bin"):is_dir() then
						-- Local Poetry environment
						config.settings.python.pythonPath = tostring(venv:joinpath("bin", "python"))
					elseif flake_file:is_file() then
						-- Get the Python interpreter from the devShell environment
						local result = Job:new({
							command = "nix",
							args = { "develop", "--command", "which", "python" },
							cwd = config.root_dir,
						}):sync()

						if result and #result > 0 then
							config.settings.python.pythonPath = vim.trim(result[1])
						else
							-- Fallback to system Python
							config.settings.python.pythonPath = vim.fn.exepath("python3")
								or vim.fn.exepath("python")
								or "python"
						end
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
