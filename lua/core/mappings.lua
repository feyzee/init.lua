-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- vim.keymap.set({'n', 'v'}, '<leader>ti', vim.lsp.buf.references, { buffer=true })
-- keymap("n", "<leader>ti", ":!terraform init<CR>", opts)
-- keymap("n", "<leader>tv", ":!terraform validate<CR>", opts)

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set('n', '<leader>ti', vim.lsp.buf.references, { buffer=true })
-- keymap("n", "<leader>ti", ":!terraform init<CR>", opts)
-- keymap("n", "<leader>tv", ":!terraform validate<CR>", opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Telescope. See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>gst', require('telescope.builtin').git_status, { desc = '[G]it [ST]atus' })
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>def', require('telescope.builtin').lsp_definitions, { desc = 'LSP [DEF]initions' })
vim.keymap.set('n', '<leader>ref', require('telescope.builtin').lsp_references, { desc = 'LSP [REF]erences' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })

-- vim.keymap.set('n', '<C-w>h','', {silent = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap=true, silent=true })

-- CMP mappings
 -- window = {
 --   documentation = cmp.config.window.bordered(),
 -- },
 -- mapping = {
 --   ['<Tab>'] = cmp.mapping.select_next_item(),
 --   ['<S-Tab>'] = cmp.mapping.select_prev_item(),
 --   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
 --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
 --   ['<C-space>'] = cmp.mapping.complete(),
 --   ['<C-e>'] = cmp.mapping.close(),
 --   ['<CR>'] = cmp.mapping.confirm({
 --     behavior = cmp.ConfirmBehavior.Insert,
 --     select = false,
 --   }),
 -- },

vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap=true, silent=true })
