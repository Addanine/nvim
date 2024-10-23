return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require('tokyonight').setup({
        style = "night",
        transparent = false,
      })
      vim.cmd([[colorscheme tokyonight]])
    end
  }
}
