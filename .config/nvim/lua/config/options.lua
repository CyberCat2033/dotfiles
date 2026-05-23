-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_python_lsp = "pyright"

vim.env.MASON = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
local mason_bin = vim.env.MASON .. "/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.wrap = false

vim.filetype.add({
  extension = { hl = "hyprlang" },
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
