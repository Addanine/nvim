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

    {
    'yacineMTB/dingllm.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local system_prompt =
        'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
      local helpful_prompt = 'You are a helpful assistant. What I have sent are my notes so far.'
      local dingllm = require 'dingllm'


      local function handle_open_router_spec_data(data_stream)
        local success, json = pcall(vim.json.decode, data_stream)
        if success then
          if json.choices and json.choices[1] and json.choices[1].text then
            local content = json.choices[1].text
            if content then
              dingllm.write_string_at_cursor(content)
            end
          end
        else
          print("non json " .. data_stream)
        end
      end

      local function custom_make_openai_spec_curl_args(opts, prompt)
        local url = opts.url
        local api_key = opts.api_key_name and os.getenv(opts.api_key_name)
        local data = {
          prompt = prompt,
          model = opts.model,
          temperature = 0.7,
          stream = true,
        }
        local args = { '-N', '-X', 'POST', '-H', 'Content-Type: application/json', '-d', vim.json.encode(data) }
        if api_key then
          table.insert(args, '-H')
          table.insert(args, 'Authorization: Bearer ' .. api_key)
        end
        table.insert(args, url)
        return args
      end

      local function anthropic_help()
        dingllm.invoke_llm_and_stream_into_editor({
          url = 'https://api.anthropic.com/v1/messages',
          model = 'claude-3-5-sonnet-20240620',
          api_key_name = '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',
          system_prompt = helpful_prompt,
          replace = false,
        }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
      end

      local function anthropic_replace()
        dingllm.invoke_llm_and_stream_into_editor({
          url = 'https://api.anthropic.com/v1/messages',
          model = 'claude-3-5-sonnet-20240620',
          api_key_name = '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',
          system_prompt = system_prompt,
          replace = true,
        }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
      end
      vim.keymap.set({ 'n', 'v' }, '<leader>I', anthropic_help, { desc = 'llm anthropic_help' })
      vim.keymap.set({ 'n', 'v' }, '<leader>i', anthropic_replace, { desc = 'llm anthropic' })
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
vim.keymap.set('v', '<S-Del>', 'd', { noremap = true, silent = true })
