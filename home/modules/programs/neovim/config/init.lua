-- bootstrap lazy.nvim, LazyVim and your plugins
pcall(require, "envs")
require("config.lazy")

-- fnm puts active node at ~/.local/share/fnm/aliases/default/bin
local fnm_default = vim.fn.expand("$HOME/.local/share/fnm/aliases/default/bin")
if vim.fn.isdirectory(fnm_default) == 1 then
	vim.env.PATH = fnm_default .. ":" .. vim.env.PATH
end
