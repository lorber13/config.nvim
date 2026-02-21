return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- optional but recommended
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    {
      "<leader>s",
      "<cmd>Telescope find_files<cr>",
      desc = "Find files",
    },
    {
      "<leader><leader>",
      "<cmd>Telescope live_grep<cr>",
      desc = "Search everywhere",
    },
  },
}
