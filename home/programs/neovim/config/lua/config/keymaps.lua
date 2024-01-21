-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local harpoon = require("harpoon")
local set = vim.keymap.set

harpoon:setup()

-- harpoon keymaps
set("n", "<leader>a", function()
	harpoon:list():append()
end)
set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
set("n", "<C-s>", function()
	harpoon:list():select(4)
end)

set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

-- window keymaps
set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })

-- editor keymaps
set("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards", silent = true })
set("n", "<leader>cs", "<cmd>noautocmd w<cr>", { desc = "Save without formatting", silent = true })
set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Show symbols outline", silent = true })

-- code keymaps
set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below", silent = true })

-- terminal keymaps
set("t", "<C-l>", "<C-\\><C-n><C-l>", { desc = "Clear terminal", silent = true })
set("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Scroll terminal down", silent = true })
set("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Scroll terminal up", silent = true })
