return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        strings = { "italic" },
        variables = { "italic" },
      },
      integrations = {
        mason = true,
        telescope = true,
        nvimtree = true,
        treesitter = true,
      },
      custom_highlights = function(colors)
        return {
          Normal = { fg = colors.text },
          LineNr = { fg = colors.overlay0 },
          Comment = { fg = "#e2ccff" },  -- Lighter lavender
          String = { fg = "#ffd6ec" },   -- Lighter pink
          Function = { fg = "#d4ffd4" }, -- Lighter mint
          Keyword = { fg = "#ccf5ff" },  -- Lighter sky blue
        }
      end,
      color_overrides = {
        mocha = {
          text = "#ffd6ec",       -- Light pink for text
          subtext1 = "#e2ccff",   -- Light lavender
          subtext0 = "#d4ffd4",   -- Light mint
          overlay2 = "#ccf5ff",   -- Light sky blue
          overlay1 = "#ffe2f5",   -- Light peach
          overlay0 = "#fff2d9",   -- Light yellow
          surface2 = "#585b70",
          surface1 = "#45475a",
          surface0 = "#313244",
          base = "#1e1e2e",       -- Dark background
          mantle = "#181825",
          crust = "#11111b",
        },
      },
    },
  },
}
