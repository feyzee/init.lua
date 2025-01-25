local keymap = vim.keymap.set
local opts = { noremap=true, silent=true }
local hop = require('hop')
local directions = require('hop.hint').HintDirection

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Fold related keymaps
keymap('n', '+', ":foldopen<CR>", { desc = "Open code fold" })
keymap('n', '-', ":foldclose<CR>", { desc = "Close code fold" })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
keymap('n', '<leader>e', vim.diagnostic.open_float)
keymap('n', '<leader>q', vim.diagnostic.setloclist)

-- Telescope. See `:help telescope.builtin`
keymap('n', '<leader>-', ":Telescope file_browser<CR>", { desc = 'Open File Browser' })
keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

keymap('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- keymap('n', '<leader>sg', require('telescope.builtin').live_grep({search_dirs = {"."}}) , { desc = '[S]earch by Grep [C]urrent Directory' })
keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
keymap('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
keymap('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })
keymap('n', '<leader>gst', require('telescope.builtin').git_status, { desc = '[G]it [ST]atus' })
keymap('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[G]it [C]ommits' })
keymap('n', '<leader>gb', require('telescope.builtin').git_branches	, { desc = '[G]it [B]ranches' })
keymap('n', '<leader>gsh', require('telescope.builtin').git_stash, { desc = '[G]it [S]tas[H]' })
keymap('n', '<leader>def', require('telescope.builtin').lsp_definitions, { desc = 'LSP [DEF]initions' })
keymap('n', '<leader>ref', require('telescope.builtin').lsp_references, { desc = 'LSP [REF]erences' })
keymap('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
keymap('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
keymap('n', '<leader>ts', require('telescope.builtin').treesitter, { desc = '[T]ree[S]itter' })

-- Window management
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize +2<CR>", opts)

-- Text
keymap("n", "<A-Up>", "<Esc>:m .-2<CR>==", opts)
keymap("n", "<A-Down>", "<Esc>:m .+1<CR>==", opts)

-- File manipulation
-- keymap("n", "<C-s>", ":w<cr>", opts)

-- Neotree
keymap("n", "<leader>b", ":Neotree toggle<cr>", opts)
keymap("n", "<leader>bf", ":Neotree focus<cr>", opts)

-- Terraform
keymap("n", "<leader>tfi", ":!terraform init<CR>", opts)
keymap("n", "<leader>tfv", ":!terraform validate<CR>", opts)
keymap("n", "<leader>tfmt", ":!terraform fmt<CR>", opts)

-- hop.nvim
-- keymap('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- keymap('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- keymap('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- keymap('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})
keymap("n", "<leader>h", ":HopAnywhere<CR>", opts)
