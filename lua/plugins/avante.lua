return {
  {
    "yetone/avante.nvim",
    branch = "main",
    dependencies = {
      "MunifTanjim/nui.nvim",  -- This provides nui.split
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("avante").setup({
        -- Add any configuration options here
      })
    end
  }
}
