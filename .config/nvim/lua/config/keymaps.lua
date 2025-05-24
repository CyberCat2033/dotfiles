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
map("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", default_opts)
map("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", default_opts)
map("n", "<F6>", "<cmd>lua require'dap'.pause()<CR>", default_opts)
map("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", default_opts)
