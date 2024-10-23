return {
    'Addanine/aurore',
    dir = vim.fn.expand("~/dev/aurore"), -- Adjust this path to where you cloned the repo
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('aurore').setup({
            ai_provider = "openai",
            openai_api_key = vim.env.OPENAI_API_KEY, -- Will use environment variable
            openai_model = "gpt-4",
        })
    end,
    dev = true,
}
