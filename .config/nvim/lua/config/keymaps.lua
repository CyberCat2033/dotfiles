-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

local function floating_terminal()
  Snacks.terminal.focus(vim.o.shell, {
    cwd = LazyVim.root(),
    count = 99,
    win = {
      position = "float",
      width = 0.86,
      height = 0.78,
      border = "rounded",
      title = " Terminal ",
      title_pos = "center",
    },
  })
end

local function terminal_root()
  Snacks.terminal(nil, {
    cwd = LazyVim.root(),
    count = 1,
    win = { position = "bottom", height = 0.4 },
  })
end

local function terminal_cwd()
  Snacks.terminal(nil, {
    cwd = vim.uv.cwd(),
    count = 1,
    win = { position = "bottom", height = 0.4 },
  })
end

map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", "Next Buffer")
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer")
map("n", "<F4>", "<cmd>Neotree focus<CR>", "Focus Explorer")
map("n", "<leader>ft", terminal_root, "Terminal (Root Dir)")
map("n", "<leader>fT", terminal_cwd, "Terminal (cwd)")
map({ "n", "t" }, "<C-/>", floating_terminal, "Floating Terminal (Root Dir)")
map({ "n", "t" }, "<C-_>", floating_terminal, "Floating Terminal (Root Dir)")
map({ "n", "t" }, "<C-\\>", floating_terminal, "Floating Terminal (Root Dir)")
map("n", "<F12>", vim.lsp.buf.definition, "Goto Definition")
map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
map("n", "<F10>", function()
  require("dap").step_over()
end, "DAP Step Over")
map("n", "<F11>", function()
  require("dap").step_into()
end, "DAP Step Into")
map("n", "<F6>", function()
  require("dap").pause()
end, "DAP Pause")
map("n", "<F5>", function()
  require("dap").continue()
end, "DAP Continue")
