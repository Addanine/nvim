-- Set up lazy.nvim path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- General Settings
vim.opt.number = true

vim.opt.mouse = "a"

vim.opt.laststatus = 3

-- Enable GUI colors for better theme support
vim.opt.termguicolors = true

-- Set <leader> key to Space
vim.g.mapleader = " "


-- Configure lazy.nvim
require("lazy").setup({

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "python", "javascript" }, -- Add languages as needed
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },

  -- Theme: tokyonight
  {
    "folke/tokyonight.nvim",
    config = function()
      require('tokyonight').setup({
        style = "night", -- "storm", "night", or "day"
        transparent = false, -- Enable/disable background transparency
      })
      vim.cmd([[colorscheme tokyonight]])
    end
  },

  -- File Explorer: nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require('nvim-tree').setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_opened_files = "name",
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
    end
  },

  -- Fuzzy Finder: Telescope and FZF
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup()
      require('telescope').load_extension('fzf')
      vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  -- LSP Configuration: ts_ls
  {
    "neovim/nvim-lspconfig",
    config = function()
      require('lspconfig').ts_ls.setup{}
    end
  },

  -- Autocompletion: nvim-cmp and LuaSnip
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'luasnip' },
        },
      })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },





  -- Status Line: lualine and Devicons
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup()
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup()
    end
  },

  -- Tabline for buffers: barbar.nvim
  {
    "romgrk/barbar.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.g.bufferline = { animation = true, icons = true }
    end
  },

  -- Code commenting
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end
  },

  -- Color highlighting for hex values
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
  },

  -- Code formatting and diagnostics
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
        },
      })
    end,
  },
})

-- Key Mappings

-- Command + Tab to toggle NvimTree
-- Key Mappings

-- Load additional configurations after plugins are set up
require('config.avante_keys')  
require('config.avante')

-- Avante.nvim Key Bindings
-- Toggle NvimTree using <leader>e (Space + e)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Go to the end of the line using <leader>l (Space + l)
vim.keymap.set('n', '<leader>l', '$', { noremap = true, silent = true })
vim.keymap.set('i', '<leader>l', '<C-o>$', { noremap = true, silent = true })

-- Go to the start of the line using <leader>h (Space + h)
vim.keymap.set('n', '<leader>h', '0', { noremap = true, silent = true })
vim.keymap.set('i', '<leader>h', '<C-o>0', { noremap = true, silent = true })

-- Delete the current line using <leader>d (Space + d)
vim.keymap.set('n', '<leader>d', 'dd', { noremap = true, silent = true })
vim.keymap.set('i', '<leader>d', '<Esc>ddi', { noremap = true, silent = true })

-- Key mappings for buffer navigation (barbar.nvim)
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bc', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
