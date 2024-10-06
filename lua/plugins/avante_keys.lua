-- ~/.config/nvim/lua/config/avante_keys.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Ensure the leader key is set (commonly it's " " for space)
vim.g.mapleader = " "  -- Adjust if different

-- ======== Avante.nvim Key Bindings ========

-- 1. Shift + E to Toggle Avante Sidebar (Overrides any existing <S-e> mappings)
map('n', '<S-e>', ':AvanteSidebarToggle<CR>', opts)  -- Show/Hide Avante Sidebar

-- 2. Refresh Avante Sidebar
map('n', '<leader>ar', ':AvanteSidebarRefresh<CR>', opts)     -- Refresh sidebar

-- 3. Edit Selected Blocks
map('n', '<leader>ae', ':AvanteEditSelected<CR>', opts)      -- Edit selected blocks

-- 4. Conflict Mappings
map('n', 'co', ':AvanteChooseOurs<CR>', opts)
map('n', 'ct', ':AvanteChooseTheirs<CR>', opts)
map('n', 'ca', ':AvanteChooseAllTheirs<CR>', opts)
map('n', 'c0', ':AvanteChooseNone<CR>', opts)
map('n', 'cb', ':AvanteChooseBoth<CR>', opts)
map('n', 'cc', ':AvanteChooseCursor<CR>', opts)
map('n', ']x', ':AvanteNextConflict<CR>', opts)
map('n', '[x', ':AvantePrevConflict<CR>', opts)

-- 5. Suggestion Mappings
map('n', '<M-l>', ':AvanteAcceptSuggestion<CR>', opts)
map('n', '<M-]>', ':AvanteNextSuggestion<CR>', opts)
map('n', '<M-[>', ':AvantePrevSuggestion<CR>', opts)
map('n', '<C-]>', ':AvanteDismissSuggestion<CR>', opts)

-- 6. Jump Mappings
map('n', ']]', ':AvanteJumpNextCodeblock<CR>', opts)
map('n', '[[', ':AvanteJumpPrevCodeblock<CR>', opts)

-- 7. Submit Mappings
map('n', '<CR>', ':AvanteSubmitNormal<CR>', opts)
map('i', '<C-s>', '<Esc>:AvanteSubmitInsert<CR>', opts)

-- 8. Sidebar Window Switching
map('n', '<Tab>', ':AvanteSwitchWindow<CR>', opts)
map('n', '<S-Tab>', ':AvanteReverseSwitchWindow<CR>', opts)

-- ======== End of Avante.nvim Key Bindings ========

