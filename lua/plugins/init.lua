local mason_options = require("plugins.config.mason")
local lazy_plugins = require("plugins.config.lazy").plugins
local lazy_options = require("plugins.config.lazy").options
local treesitter_options = require("plugins.config.treesitter")
local cmp_options = require("plugins.config.cmp")
local blankline_options = require("plugins.config.blankline")
local whichkey_options = require("plugins.config.which-key")
local luasnip_options = require("plugins.config.luasnip")
local nvimtree_options = require("plugins.config.nvimtree")

-- Lazy initialization
require("lazy").setup(lazy_plugins, lazy_options)
require("mason").setup(mason_options)

-- LSP Plugins
-- require("nvim-lspconfig").setup("plugins.config.lspconfig")
require("nvim-treesitter.configs").setup(treesitter_options)
require("cmp").setup(cmp_options)

-- Plugins initialization
require("plugins.config.lualine")
require('fidget').setup()
require('neodev').setup()
require('Comment').setup()
require("indent_blankline").setup(blankline_options)
require("which-key").setup(whichkey_options)
require("nvim-tree").setup(nvimtree_options)
--require("luasnip").setup(luasnip_options)
