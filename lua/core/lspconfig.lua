-- export on_attach & capabilities for custom lspconfigs
vim.lsp.protocol.CompletionItemKind = {
  ' (text)',
  ' (method)',
  '󰊕 (function)',
  ' (constructor)',
  'ﰠ (field)',
  '󰫧 (variable)',
  ' (class)',
  ' (interface)',
  ' (module)',
  ' (property)',
  ' (unit)',
  ' (value)',
  ' (enum)',
  ' (key)',
  ' (snippet)',
  ' (color)',
  ' (file)',
  ' (reference)',
  ' (folder)',
  ' (enum member)',
  ' (constant)',
  ' (struct)',
  ' (event)',
  ' (operator)',
  ' (type)',
}

-- FIXME: use lua instead of vim.cmd
-- Diagnostics icons
-- vim.fn.sign_define(
--   "LspDiagnosticsSignError",
--   { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
-- )
-- vim.fn.sign_define(
--   "LspDiagnosticsSignWarning",
--   { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
-- )
-- vim.fn.sign_define(
--   "LspDiagnosticsSignHint",
--   { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
-- )
-- vim.fn.sign_define(
--   "LspDiagnosticsSignInformation",
--   { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
-- )
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- vim.cmd [[
--   sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
--   sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
--   sign define DiagnosticSignInfo text=  linehl= texthl=DiagnosticSignInfo numhl=
--   sign define DiagnosticSignHint text=   linehl= texthl=DiagnosticSignHint numhl=
-- ]]


local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-S>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local lspconfig = require("lspconfig")
local servers = {
    "tsserver",
    "bashls",
    "dockerls",
    "gopls",
    "lua_ls",
    "pylsp",
    -- "python-lsp-server",
    "terraformls",
    "tflint",
    "yamlls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
      }
    }
  }
}

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      -- FIX mapKeyOrder warning
      keyOrdering = false
    }
  }
})

-- if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
--   vim.diagnostic.disable(bufnr)
--   vim.defer_fn(function()
--     vim.diagnostic.reset(nil, bufnr)
--   end, 1000)
-- end

-------------------

-- lspconfig.lua_ls.setup {
--   lua_lsp_settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
--           [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
--         },
--         maxPreload = 100000,
--         preloadFileSize = 10000,
--       },
--     },
--   },
-- }
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     -- Enable completion triggered by <c-x><c-o>
--     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--     -- Buffer local mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local opts = { buffer = ev.buf }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<space>wl', function()
--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, opts)
--     vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<space>f', function()
--       vim.lsp.buf.format { async = true }
--     end, opts)
--   end,
-- })
