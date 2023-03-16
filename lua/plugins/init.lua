local plugins = require("plugins.config.lazy").plugins
local options = require("plugins.config.lazy").options

require("lazy").setup(plugins, options)
require("plugins.config.lualine")
require('Comment').setup()
require('fidget').setup()
require('neodev').setup()
