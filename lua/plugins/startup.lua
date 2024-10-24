return {
  {
    "startup-nvim/startup.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim", 
      "nvim-lua/plenary.nvim", 
      "nvim-telescope/telescope-file-browser.nvim" 
    },
    config = function()
      local settings = {
        header = {
          type = "text",
          align = "center",
          fold_section = false,
          title = "header",
          margin = 5,
          content = {
            [[                                                                           ]],
            [[      ▄▀█ █░█ █▀█ █▀█ █▀█ █▀▀      ]],
            [[      █▀█ █▄█ █▀▄ █▄█ █▀▄ ██▄      ]],
            [[                                     ]],
            [[   ╔════════════════════════════╗   ]],
            [[   ║    Welcome back, Rose!!    ║   ]],
            [[   ╚════════════════════════════╝   ]],
            [[                                     ]],
          },
          highlight = "Statement",
          default_color = "#bb9af7",  -- Tokyo Night purple
        },

        body = {
          type = "mapping",
          align = "center",
          fold_section = false,
          title = "⚡ Quick Actions",
          margin = 5,
          content = {
            { "󰈞   Find File", "Telescope find_files", "<leader>ff" },
            { "󰊄   Find Word", "Telescope live_grep", "<leader>fg" },
            { "󰋚   Recent Files", "Telescope oldfiles", "<leader>fo" },
            { "󰉓   File Browser", "Telescope file_browser", "<leader>fb" },
            { "󰏘   Colorschemes", "Telescope colorscheme", "<leader>cs" },
            { "󰈔   New File", "lua require'startup'.new_file()", "<leader>nf" },
            { "󱐋   AI Assistant", "Aurore", "<leader>aa" },
            { "󰒲   Lazy Plugin Manager", "Lazy", "<leader>lz" },
            { "󰏖   Mason Package Manager", "Mason", "<leader>ma" },
            { "󰊢   Git Status", "Telescope git_status", "<leader>gs" },
            { "󰘬   Git Branches", "Telescope git_branches", "<leader>gb" },
            { "󰄲   Todo Comments", "TodoTelescope", "<leader>td" },
            { "󰆍   Terminal", "ToggleTerm", "<leader>tt" },
            { "󱎸   Project Settings", "Telescope projects", "<leader>pp" },
            { "󰌵   LSP Info", "LspInfo", "<leader>li" },
            { "󱉧   Diagnostics", "Telescope diagnostics", "<leader>dd" },
          },
          highlight = "String",
          default_color = "#7aa2f7",  -- Tokyo Night blue
        },

        recent_files = {
          type = "oldfiles",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "   Recent Files",
          margin = 5,
          content = {},
          highlight = "String",
          oldfiles_amount = 5,
          default_color = "#7aa2f7",  -- Changed to blue
        },

        footer = {
          type = "text",
          align = "center",
          fold_section = false,
          title = "  System Information",
          margin = 5,
          content = function()
            local lazy_stats = require("lazy").stats()
            local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
            
            local content = {
              "   Neovim loaded " .. lazy_stats.loaded .. "/" .. lazy_stats.count .. " plugins in " .. ms .. "ms",
              "",
              "System Information:",
              "   OS: macOS 15.0 24A5264n arm64",
              "   CPU: Apple M3",
              "   Memory: 16384MiB",
              "   Shell: zsh 5.9",
              "   Terminal: iTerm2",
              "",
              "󰀨  Rose's Neovim v0.10.1"
            }
            
            return content
          end,
          highlight = "NonText",
          default_color = "#7aa2f7",  -- Changed to blue
        },

        parts = {"header", "body", "recent_files", "footer"},

        options = {
          mapping_keys = true,
          cursor_column = 0.5,
          empty_lines_between_mappings = true,
          disable_statuslines = true,
          paddings = {2,2,2,2},
        },

        mappings = {
          execute_command = "<CR>",
          open_file = "o",
          open_file_split = "<c-o>",
          open_section = "<TAB>",
          open_help = "?",
        },

        colors = {
          background = "#1a1b26",
          folded_section = "#7aa2f7",
        },
      }

      -- Add number key mappings for recent files
      for i = 0, 9 do
        vim.keymap.set('n', tostring(i), function()
          local oldfiles = vim.v.oldfiles
          if i < #oldfiles then
            vim.cmd('edit ' .. oldfiles[i + 1])
          end
        end, { buffer = true, silent = true })
      end

      -- Additional mappings
      vim.keymap.set('n', '<leader>lz', ':Lazy<CR>', { silent = true })
      vim.keymap.set('n', '<leader>ma', ':Mason<CR>', { silent = true })
      vim.keymap.set('n', '<leader>gs', ':Telescope git_status<CR>', { silent = true })
      vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { silent = true })
      vim.keymap.set('n', '<leader>td', ':TodoTelescope<CR>', { silent = true })
      vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { silent = true })
      vim.keymap.set('n', '<leader>pp', ':Telescope projects<CR>', { silent = true })
      vim.keymap.set('n', '<leader>li', ':LspInfo<CR>', { silent = true })
      vim.keymap.set('n', '<leader>dd', ':Telescope diagnostics<CR>', { silent = true })

      require("startup").setup(settings)
    end
  }
}
