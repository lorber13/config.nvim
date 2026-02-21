return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filters = {
      dotfiles = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    view = {
      width = {},
    },
    update_focused_file = {
      enable = true,
    },
    renderer = {
      group_empty = true,
    },
  },
  keys = {
    {
      "<leader>e",
      "<cmd>NvimTreeToggle<cr>",
      desc = "File picker",
    },
  },
}
