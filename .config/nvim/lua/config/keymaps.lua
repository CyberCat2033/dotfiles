-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
map("n", "<Tab>", ":BufferLineCycleNext<CR>", default_opts)
map("n", "<S-Tab>", "BufferLineCycleNext<CR>", default_opts)
map("n", "<F4>", ":Neotree<CR> focus", default_opts)
map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", default_opts)
-- map("C", "<F12>", "<cmd>lua vim.lsp.buf.rename()<CR>", default_opts)
map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", default_opts)
