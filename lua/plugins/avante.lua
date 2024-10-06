-- ~/.config/nvim/lua/config/avante.lua

local avante = require('avante')

-- Load avante_lib as per documentation
require('avante_lib').load()

-- Setup avante with your configuration
avante.setup({
  provider = "claude", -- or "openai"
  auto_suggestions_provider = "copilot", -- for cheaper suggestions

  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20240620",
    temperature = 0,
    max_tokens = 4096,
    api_key = os.getenv("ANTHROPIC_API_KEY"), -- Securely load Claude API key
  },

  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "gpt-4o", -- Adjust based on your needs
    temperature = 0.7,
    max_tokens = 2048,
    api_key = os.getenv("OPENAI_API_KEY"), -- Securely load OpenAI API key
  },

  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },

  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    sidebar = {
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },

  hints = { enabled = true },

  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- the position of the sidebar
    wrap = true, -- similar to vim.o.wrap
    width = 30, -- default % based on available width
    sidebar_header = {
      align = "center", -- left, center, right for title
      rounded = true,
    },
  },

  highlights = {
    ---@type AvanteConflictHighlights
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },

  --- @class AvanteConflictUserConfig
  diff = {
    autojump = true,
    ---@type string | fun(): any
    list_opener = "copen",
  },
})

