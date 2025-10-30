local lazy_plugins = require("plugins.lazy_plugins")
local lazy_options = require("plugins.lazy_options")

-- Plugin managers initialization
require("lazy").setup(lazy_plugins, lazy_options)
require("mason").setup(require("plugins.config.mason"))

-- Plugins initialization
require("nvim-treesitter.configs").setup(require("plugins.config.treesitter"))
require("luasnip").setup() -- luasnip needs to be invoked before cmp.
-- require("luasnip").setup("plugins.config.luasnip") -- luasnip needs to be invoked before cmp.
require("cmp").setup(require("plugins.config.cmp"))
require("telescope").setup(require("plugins.config.telescope"))
require("telescope").load_extension("zoxide")
-- require("null-ls").setup(require("plugins.config.null-ls"))
require("fidget").setup()
require("lazydev").setup()
require("Comment").setup()
-- require("arrow").setup(require("plugins.config.arrow"))
-- -- require("tabby").setup()
require('lualine').setup(require("plugins.config.lualine"))
require("indent_blankline").setup()
-- require("gitsigns").setup(require("plugins.config.gitsigns"))
require("gitsigns").setup()
require("which-key").setup(require("plugins.config.which-key"))
require("nvim-autopairs").setup(require("plugins.config.nvim-autopairs"))
require("neo-tree").setup(require("plugins.config.neotree"))
require("noice").setup(require("plugins.config.noice"))
require("mini.files").setup()
require("catppuccin").setup(require("plugins.config.catppuccin"))
require("trouble").setup(require("plugins.config.trouble"))
-- require("neogit").setup()
-- require("neorg").setup(require("plugins.config.neorg"))
require("hop").setup()
-- require("vim-helm").setup()
require("todo-comments").setup(require("plugins.config.todo-comments"))
require("zen-mode").setup(require("plugins.config.zen-mode"))
require("go").setup()
-- require("navigator").setup()
-- require("log-highlight").setup()
require('log-highlight').setup {
    ---@type string|string[]: File extensions. Default: 'log'
    extension = 'log',

    ---@type string|string[]: File names or full file paths. Default: {}
    filename = {
        'syslog',
    },

    ---@type string|string[]: File name/path glob patterns. Default: {}
    pattern = {
        -- Use `%` to escape special characters and match them literally.
        '%/var%/log%/.*',
        'console%-ramoops.*',
        'log.*%.txt',
        'logcat.*',
    },

    ---@type table<string, string|string[]>: Custom keywords to highlight.
    ---This allows you to define custom keywords to be highlighted based on
    ---the group.
    ---
    ---The following highlight groups are supported:
    ---    'error', 'warning', 'info', 'debug' and 'pass'.
    ---
    ---The value for each group can be a string or a list of strings.
    ---All groups are empty by default. Keywords are case-sensitive.
    keyword = {
        error = 'ERROR_MSG',
        warning = { 'WARN_X', 'WARN_Y' },
        info = { 'INFORMATION' },
        debug = {},
        pass = {},
    },
}
