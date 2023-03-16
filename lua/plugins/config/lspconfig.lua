dofile(vim.g.base46_cache .. "lsp")

local M = {}

-- export on_attach & capabilities for custom lspconfigs

vim.lsp.protocol.CompletionItemKind = {
  ' (text)',
  ' (method)',
  ' (function)',
  ' (constructor)',
  'ﰠ (field)',
  ' (variable)',
  ' (class)',
  ' (interface)',
  ' (module)',
  ' (property)',
  ' (unit)',
  ' (value)',
  ' (enum)',
  ' (key)',
  '﬌ (snippet)',
  ' (color)',
  ' (file)',
  ' (reference)',
  ' (folder)',
  ' (enum member)',
  ' (constant)',
  ' (struct)',
  ' (event)',
  ' (operator)',
  ' (type)',
}

local signs = {
  Error = vim.g.diagnostic_icons.Error,
  Warn = vim.g.diagnostic_icons.Warning,
  Hint = vim.g.diagnostic_icons.Hint,
  Info = vim.g.diagnostic_icons.Information,
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

M.on_attach = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

return M
