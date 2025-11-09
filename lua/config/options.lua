-- vim.opt.encoding = utf8

vim.o.number = true
vim.o.relativenumber = true

-- Wrapping, whitespace characters and indents
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.list = true
vim.opt.listchars = { eol = "↴", lead = "⋅", nbsp = "␣", tab = "→ ", trail = "⋅" }

-- Tabs vs spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.mouse = "a"
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.updatetime = 250
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.hlsearch = false
vim.o.cursorline = true

-- splits
vim.o.splitbelow = true
vim.o.splitright = true

-- fold
vim.o.foldcolumn = "0"
vim.o.foldtext = ""
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'


vim.cmd [[colorscheme tokyonight]]
vim.api.nvim_set_option_value("colorcolumn", "79", {})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.timeoutlen = 500
