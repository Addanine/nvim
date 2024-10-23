return {
  -- UI enhancements
  { "nvim-lualine/lualine.nvim" },
  { "romgrk/barbar.nvim" },
  { "numToStr/Comment.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "karb94/neoscroll.nvim" },
  { "norcalli/nvim-colorizer.lua" },

  -- Additional utilities
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true
  }
}
