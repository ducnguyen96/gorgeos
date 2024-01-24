-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- improve undo
local keys = vim.fn.split(". , ? ! <space>", " ")
for _, key in ipairs(keys) do
	vim.api.nvim_set_keymap("i", key, "<c-g>u" .. key, { noremap = true, silent = true })
end
