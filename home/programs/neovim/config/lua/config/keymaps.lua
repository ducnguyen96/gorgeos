-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })

set("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards", silent = true })
set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Show symbols outline", silent = true })

-- insert new line without entering insert mode
set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below", silent = true })

-- save without formatting
set("n", "<leader>cs", "<cmd>noautocmd wcr>", { desc = "Save without formatting", silent = true })
