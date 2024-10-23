return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      })
    end
  }
}