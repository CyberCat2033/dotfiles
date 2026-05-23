local function local_server(cmd, opts)
  if vim.fn.executable(cmd) == 1 then
    return opts or {}
  end

  return { enabled = false }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hyprls = local_server("hyprls", { mason = false }),
        qmlls = local_server("qmlls", { mason = false }),
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli",
        "stylua",
        "shfmt",
        "shellcheck",
        "prettier",
        "debugpy",
        "netcoredbg",
      },
    },
  },
}
