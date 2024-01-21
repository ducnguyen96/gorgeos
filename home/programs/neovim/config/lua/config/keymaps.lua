-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local harpoon = require("harpoon")
local set = vim.keymap.set

harpoon:setup()

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

-- Toggle previous & next buffers stored within Harpoon list
set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })

set("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards", silent = true })
set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Show symbols outline", silent = true })

-- insert new line without entering insert mode
set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below", silent = true })

-- save without formatting
set("n", "<leader>cs", "<cmd>noautocmd w<cr>", { desc = "Save without formatting", silent = true })
