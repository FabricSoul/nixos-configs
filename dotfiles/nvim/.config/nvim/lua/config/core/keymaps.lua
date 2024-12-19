vim.g.mapleader = " "

local km = vim.keymap


-- Visual Mode --
km.set("v", "J", ":m '>+1<CR>gv=gv")
km.set("v", "K", ":m '<-2<CR>gv=gv")

-- Normal Mode -- 
-- Window
km.set("n", "<leader>sv", "<C-w>v")
km.set("n", "<leader>sh", "<C-w>s")

