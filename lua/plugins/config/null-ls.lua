local null_ls = require('null-ls')
local formatter = null_ls.builtins.formatting

return {
  sources = {
    formatter.black,
    formatter.codespell.with({
      filetypes = {'markdown', 'txt'}
    }),
    formatter.eslint_d,
    formatter.gofmt,
    formatter.goimports,
    formatter.goimports_reviser,
    formatter.hclfmt,
    formatter.markdownlint,
    formatter.mdformat,
    formatter.nginx_beautifier,
    formatter.prettier_d_slim,
    formatter.terraform_fmt,
    formatter.stylua,
    null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client)
    if client.server_capabilities.document_formatting then
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        vim.lsp.buf.formatting_sync()
      })
    end
  end
}
