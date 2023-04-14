local lazy_plugins = require("plugins.config.lazy").plugins
local lazy_options = require("plugins.config.lazy").options

-- Plugin managers initialization
require("lazy").setup(lazy_plugins, lazy_options)
require("mason").setup(require("plugins.config.mason"))

-- Plugins initialization
require("nvim-treesitter.configs").setup(require("plugins.config.treesitter"))
--require("luasnip").setup("plugins.config.luasnip") -- luasnip needs to be invoked before cmp.
require("cmp").setup(require("plugins.config.cmp"))
require("telescope").setup(require("plugins.config.telescope"))
require("telescope").load_extension("zoxide")
require("null-ls").setup(require("plugins.config.null-ls"))
require("plugins.config.lualine")
require("fidget").setup()
require("neodev").setup()
require("Comment").setup()
require('lualine').setup(require("plugins.config.lualine"))
require("indent_blankline").setup(require("plugins.config.blankline"))
require("gitsigns").setup(require("plugins.config.gitsigns"))
require("which-key").setup(require("plugins.config.which-key"))
require("nvim-autopairs").setup(require("plugins.config.nvim-autopairs"))
require("nvim-tree").setup(require("plugins.config.nvimtree"))
require("nvim-navbuddy").setup(require("plugins.config.nvimtree"))
require("catppuccin").setup(require("plugins.config.catppuccin"))
require("trouble").setup(require("plugins.config.trouble"))
require("auto-session").setup(require("plugins.config.auto-session"))
require("hop").setup()
