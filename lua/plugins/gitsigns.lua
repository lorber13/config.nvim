return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    signs = {
      add = { text = "+" },
      change = { text = "~" },
    },
    signs_staged = {
      add = { text = "+" },
      change = { text = "~" },
    },
  },
  keys = {
    {
      "]c",
      function()
        require("gitsigns").nav_hunk("next")
      end,
      desc = "Next Git change",
    },
    {
      "[c",
      function()
        require("gitsigns").nav_hunk("prev")
      end,
      desc = "Previous Git change",
    },
  },
}
