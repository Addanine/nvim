---@diagnostic disable: undefined-global

-- Set up lazy.nvim path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- General Settings
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.mousemodel = "extend"
vim.opt.mouse = "a"

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("tsserver.*deprecated") then
        return
    end
    notify(msg, ...)
end

-- Configure lazy.nvim
require("lazy").setup("plugins")
vim.cmd.colorscheme("catppuccin")
-- Key Mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- File navigation
map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fb', ':Telescope file_browser<CR>')

-- Line navigation
map('n', '<leader>l', '$')
map('i', '<leader>l', '<C-o>$')
map('n', '<leader>h', '0')
map('i', '<leader>h', '<C-o>0')

-- Buffer management
map('n', '<leader>bn', '<Cmd>BufferNext<CR>')
map('n', '<leader>bp', '<Cmd>BufferPrevious<CR>')
map('n', '<leader>bc', '<Cmd>BufferClose<CR>')

-- Additional features
map('n', '<leader>tt', ':TroubleToggle<CR>')
map('n', '<leader>td', ':TodoTrouble<CR>')
map('n', '<leader>gg', ':DiffviewOpen<CR>')
