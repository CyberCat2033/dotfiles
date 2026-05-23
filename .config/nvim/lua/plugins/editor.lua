return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" },
      { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil (Current Directory)" },
      {
        "<leader>fO",
        function()
          require("oil").open(vim.uv.cwd())
        end,
        desc = "Oil (cwd)",
      },
    },
    opts = {
      default_file_explorer = false,
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gQ", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
    opts = {},
  },
}
