return {
    'Addanine/aurore',
    dir = vim.fn.expand("~/Developer/aurore"),
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local anthropic_key = vim.env.ANTHROPIC_API_KEY
        if not anthropic_key then
            vim.notify("Anthropic API key not found! Please set ANTHROPIC_API_KEY environment variable", vim.log.levels.ERROR)
            return
        end
        
        local config = {
            ai_provider = "anthropic",
            anthropic_api_key = anthropic_key,
            anthropic_model = "claude-3-5-sonnet-20241022",
            quiet = true  -- Disable startup messages
        }
        
        -- Initialize with error handling
        local ok, err = pcall(function()
            require('aurore').setup(config)
        end)
        
        if not ok then
            vim.notify("Failed to initialize Aurore: " .. tostring(err), vim.log.levels.ERROR)
        end
    end,
    dev = true,
    lazy = false,
}
