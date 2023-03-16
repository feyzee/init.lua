vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "tab:→"
vim.opt.listchars:append "eol:↴"
vim.opt.hlsearch = false

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true


vim.cmd [[colorscheme catppuccin-macchiato]]
vim.api.nvim_set_option_value("colorcolumn", "79", {})

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.opt.timeoutlen = 500

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Terraform file association
-- vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
-- vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.api.nvim_create_autocmd({ "BufWritePre", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars" },
  command = "set filetype=terraform"
})

vim.api.nvim_create_autocmd({ "BufWritePre", "BufNewFile" }, {
  pattern = { "*.hcl", ".terraformrc", "terraform.rc" },
  command = "set filetype=hcl"
})

vim.api.nvim_create_autocmd({ "BufWritePre", "BufNewFile" }, {
  pattern = { "*.tfstate", "*.tfstate.backup" },
  command = "set filetype=json"
})

