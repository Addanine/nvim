return {
  {
    "Addanine/aurore",
    dependencies = { 
      "nvim-lua/plenary.nvim" 
    },
    config = function()
      require("aurore").setup({
        api_key = vim.env.ANTHROPIC_API_KEY,
        xdotool = {
          enabled = true,
          delay = 50,
          safe_mode = true,
          excluded_apps = {
            "sudo",
            "rm",
            "passwd",
            "su"
          }
        }
      })
    end,
    cmd = { "Aurore" },
    keys = {
      { "<leader>aa", "<cmd>Aurore<cr>", desc = "Ask Aurore" }
    }
  }
}
