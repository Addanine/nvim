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
-- Add to your init.lua
vim.api.nvim_create_user_command('AuroreDebug', function()
    local ok, aurore = pcall(require, 'aurore')
    if not ok then
        print("Failed to load aurore module!")
        return
    end

    local diagnostic = {
        module = {
            loaded = ok,
            setup_exists = type(aurore.setup) == "function",
            is_initialized_exists = type(aurore.is_initialized) == "function"
        },
        state = {
            config_exists = aurore.config ~= nil,
            is_initialized = type(aurore.is_initialized) == "function" and aurore.is_initialized() or false
        },
        environment = {
            api_key_set = vim.env.ANTHROPIC_API_KEY ~= nil,
            plugin_path = vim.fn.expand("~/Developer/aurore"),
            plugin_path_exists = vim.fn.isdirectory(vim.fn.expand("~/Developer/aurore")) == 1
        }
    }

    print("\nAurore Detailed Diagnostic Information:")
    print("\nModule Status:")
    print(string.format("  - Module Loaded: %s", tostring(diagnostic.module.loaded)))
    print(string.format("  - Setup Function Exists: %s", tostring(diagnostic.module.setup_exists)))
    print(string.format("  - Is Initialized Function Exists: %s", tostring(diagnostic.module.is_initialized_exists)))
    
    print("\nState:")
    print(string.format("  - Config Present: %s", tostring(diagnostic.state.config_exists)))
    print(string.format("  - Is Initialized: %s", tostring(diagnostic.state.is_initialized)))
    
    print("\nEnvironment:")
    print(string.format("  - API Key Set: %s", tostring(diagnostic.environment.api_key_set)))
    print(string.format("  - Plugin Path: %s", diagnostic.environment.plugin_path))
    print(string.format("  - Plugin Path Exists: %s", tostring(diagnostic.environment.plugin_path_exists)))

    -- Try to load config and display it
    if aurore.config then
        print("\nCurrent Config:")
        print(vim.inspect(aurore.config))
    end

    -- Add manual initialization attempt
    print("\nAttempting manual initialization...")
    local init_ok, init_err = pcall(function()
        aurore.setup({
            ai_provider = "anthropic",
            anthropic_api_key = vim.env.ANTHROPIC_API_KEY,
            anthropic_model = "claude-3-5-sonnet-20241022",
            features = {
                git_integration = true,
                lsp_integration = true,
                auto_recovery = true,
                auto_documentation = true,
            },
            task = {
                max_retries = 3,
                timeout = 30000,
                max_iterations = 5,
            }
        })
    end)
    print(string.format("Manual initialization %s", init_ok and "succeeded" or "failed: " .. tostring(init_err)))
end, {})





-- Key Mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Add this to your init.lua after lazy.setup
vim.api.nvim_create_user_command('AuroreDiag', function()
    local ok, aurore = pcall(require, 'aurore')
    if not ok then
        vim.notify("Failed to require aurore module: " .. tostring(aurore), vim.log.levels.ERROR)
        return
    end
    
    local diag = {
        module_loaded = ok,
        has_setup_function = type(aurore.setup) == "function",
        has_is_initialized = type(aurore.is_initialized) == "function",
        is_initialized = type(aurore.is_initialized) == "function" and aurore.is_initialized() or false,
        has_config = aurore.config ~= nil,
        api_key_set = vim.env.ANTHROPIC_API_KEY ~= nil
    }
    
    print("Aurore Diagnostic Information:")
    for key, value in pairs(diag) do
        print(string.format("- %s: %s", key, tostring(value)))
    end
end, {})

-- Add to your init.lua
vim.api.nvim_create_user_command('AuroreVerify', function()
    local ok, aurore = pcall(require, 'aurore')
    if not ok then
        print("Failed to load aurore module!")
        return
    end

    print("\nAurore Verification:")
    print(string.format("Module loaded: %s", ok))
    print(string.format("Setup function exists: %s", type(aurore.setup) == "function"))
    print(string.format("is_initialized exists: %s", type(aurore.is_initialized) == "function"))
    
    if type(aurore.is_initialized) == "function" then
        print(string.format("is_initialized(): %s", aurore.is_initialized()))
    end
    
    if type(aurore.get_config) == "function" then
        local config = aurore.get_config()
        print("\nCurrent config:")
        print(vim.inspect(config))
    end
    
    -- Attempt to fix initialization if needed
    if not aurore.is_initialized() then
        print("\nAttempting to reinitialize...")
        local init_ok, init_err = pcall(function()
            aurore.setup({
                ai_provider = "anthropic",
                anthropic_api_key = vim.env.ANTHROPIC_API_KEY,
                anthropic_model = "claude-3-5-sonnet-20241022",
                features = {
                    git_integration = true,
                    lsp_integration = true,
                    auto_recovery = true,
                    auto_documentation = true,
                },
                task = {
                    max_retries = 3,
                    timeout = 30000,
                    max_iterations = 5,
                }
            })
        end)
        print(string.format("Reinitialization %s", init_ok and "succeeded" or "failed: " .. tostring(init_err)))
        
        if init_ok then
            print(string.format("Verification after reinit: %s", aurore.is_initialized()))
        end
    end
end, {})



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
