return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      ui_select = true,
    },
    -- explorer = {},
  },
  keys = {
    {
      "<leader>s",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep string",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Open buffers",
    },
  },
}
