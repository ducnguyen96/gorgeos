-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

----------------------------------------------------------------
-- window keymaps
----------------------------------------------------------------

----------------------------------------------------------------
-- code keymaps
set("n", "<leader>rn", ":IncRename ")
set("n", "<leader>o", "<cmd>Oil<cr>")
----------------------------------------------------------------

----------------------------------------------------------------
-- neorg
-- set("n", "<leader>ni", "<cmd>Neorg index<cr>", { desc = "Neorg index", silent = true })
-- -- todo
-- set(
-- 	"n",
-- 	"<leader>ntc",
-- 	"<Plug>(neorg.qol.todo-items.todo.task-cycle)",
-- 	{ desc = "Neorg todo task cycle", silent = true }
-- )
----------------------------------------------------------------

----------------------------------------------------------------
-- programs
set("n", "<leader>pr", function()
	local current_dir = vim.fn.expand("%:p:h") -- Get the absolute path of the current file's directory
	vim.api.nvim_command("silent !kitty -1 -e ranger " .. current_dir)
end, { desc = "Open Kitty with Ranger at current directory" })
----------------------------------------------------------------

----------------------------------------------------------------
-- text editing
local function wrap_visual_text(before, after)
	return "c" .. before .. '<C-R>"' .. after .. "<Esc>"
end

set("v", "<leader>tb", wrap_visual_text("**", "**"), { desc = "Text bold", noremap = true, silent = true })
set("v", "<leader>ti", wrap_visual_text("*", "*"), { desc = "Text Italic", noremap = true, silent = true })
set("v", "<leader>tc", wrap_visual_text("`", "`"), { desc = "Text Inline Code", noremap = true, silent = true })
set("v", "<leader>ts", wrap_visual_text("~~", "~~"), { desc = "Text Strikethrough", noremap = true, silent = true })
set("v", "<leader>tl", wrap_visual_text("[", "](<++>)"), { desc = "Text Markdown Link", noremap = true, silent = true })
----------------------------------------------------------------
