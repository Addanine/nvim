return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_opened_files = "name",
          indent_markers = { enable = true },
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end
  }
}
