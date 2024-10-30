-- aurore.lua (in lua/plugins/)
return {
    'Addanine/aurore',
    dir = vim.fn.expand("~/Developer/aurore"),
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        -- Get API key
        local anthropic_key = vim.env.ANTHROPIC_API_KEY
        if not anthropic_key then
            vim.notify("Anthropic API key not found! Please set ANTHROPIC_API_KEY environment variable", vim.log.levels.ERROR)
            return
        end

        -- Create config
        local config = {
            ai_provider = "anthropic",
            anthropic_api_key = anthropic_key,
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
            },
            ui = {
                window_position = "bottom",
                show_progress = true,
                window_size = {
                    width = 0.8,
                    height = 0.4,
                },
            },
            debug = {
                log_level = "info",
                file_logging = true,
            },
        }

        -- Initialize using the main setup function
        local ok, aurore = pcall(require, 'aurore')
        if not ok then
            vim.notify("Failed to require aurore module: " .. tostring(aurore), vim.log.levels.ERROR)
            return
        end
        
        -- Call setup and check return value
        local setup_ok = aurore.setup(config)
        if not setup_ok then
            vim.notify("Failed to initialize Aurore", vim.log.levels.ERROR)
            return
        end

        vim.notify("Aurore initialized successfully")
    end,
    dev = true,
    lazy = false,
    priority = 1000,
}
