local lazy_plugins = require("plugins.lazy_plugins")
local lazy_options = require("plugins.lazy_options")

-- Plugin managers initialization
require("lazy").setup(lazy_plugins, lazy_options)
require("mason").setup(require("plugins.config.mason"))

-- Plugins initialization
require("nvim-treesitter.configs").setup(require("plugins.config.treesitter"))
--require("luasnip").setup("plugins.config.luasnip") -- luasnip needs to be invoked before cmp.
require("cmp").setup(require("plugins.config.cmp"))
require("telescope").setup(require("plugins.config.telescope"))
require("telescope").load_extension("zoxide")
-- require("null-ls").setup(require("plugins.config.null-ls"))
require("fidget").setup()
require("lazydev").setup()
require("Comment").setup()
require("arrow").setup(require("plugins.config.arrow"))
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
