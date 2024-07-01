-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- window keymaps
set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
set("n", "<leader>wh", "<C-W>s", { desc = "Split window horizontally", remap = true })
set("n", "<leader>wo", "<C-W>o", { desc = "Close all windows except current", remap = true })

-- editor keymaps
set("i", "<C-BS>", "<C-W>", { desc = "Delete word backwards", silent = true })
set("n", "<leader>cs", "<cmd>SymbolsOutline<cr>", { desc = "Show symbols outline", silent = true })
set("n", "<A-u>", ":m-2<CR>==", { desc = "move current line up", silent = true })
set("v", "<A-u>", ":m-2<CR>gv=gv", { desc = "move current line up", silent = true })
set("i", "<A-u>", "<Esc>:m-2<CR>==gi", { desc = "move current line up", silent = true })
set("n", "<A-d>", ":m+<CR>==", { desc = "move current line down", silent = true })
set("v", "<A-d>", ":m+<CR>gv=gv", { desc = "move current line down", silent = true })
set("i", "<A-d>", "<Esc>:m+<CR>==gi", { desc = "move current line down", silent = true })

-- code keymaps
set("n", "<leader>o", "o<ESC>", { desc = "Insert new line below", silent = true })
set("n", "<leader>sf", "<cmd>noautocmd w<cr>", { desc = "Save, format", silent = true })
set("n", "<leader>snf", "<cmd>noautocmd w<cr>", { desc = "Save no format", silent = true })
