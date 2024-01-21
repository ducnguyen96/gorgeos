-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local harpoon = require("harpoon")
local set = vim.keymap.set

harpoon:setup()

-- harpoon keymaps
set("n", "<leader>ha", function()
	harpoon:list():append()
end, { desc = "Add current file to harpoon", silent = true })

set("n", "<leader>hh", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Show harpoon menu", silent = true })

set("n", "<leader>hq", function()
	harpoon:list():select(1)
end, { desc = "Select harpoon item 1", silent = true })

set("n", "<leader>hw", function()
	harpoon:list():select(2)
end, { desc = "Select harpoon item 2", silent = true })

set("n", "<leader>he", function()
	harpoon:list():select(3)
end, { desc = "Select harpoon item 3", silent = true })

set("n", "<leader>hr", function()
	harpoon:list():select(4)
end, { desc = "Select harpoon item 4", silent = true })

set("n", "<leader>hp", function()
	harpoon:list():prev()
end, { desc = "Select harpoon prev item", silent = true })

set("n", "<leader>hn", function()
	harpoon:list():next()
end, { desc = "Select harpoon next item", silent = true })

-- window keymaps
set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })

-- editor keymaps
set("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards", silent = true })
set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Show symbols outline", silent = true })

-- code keymaps
set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below", silent = true })
set("n", "<leader>sf", "<cmd>noautocmd w<cr>", { desc = "Save, format", silent = true })
set("n", "<leader>snf", "<cmd>noautocmd w<cr>", { desc = "Save no format", silent = true })
