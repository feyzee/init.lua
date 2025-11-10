-- LSP related

vim.api.nvim_create_augroup("lspconfigs", {})

-- Auto-format ("lint") on save.
vim.api.nvim_create_autocmd("LspAttach", {
  group = "lspconfigs",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if
        not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false, bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

-- Inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "lspconfigs",
--   -- callback = function(args)
--   --   if not (args.data and args.data.client_id) then
--   --     return
--   --   end
--   --
--   --   local bufnr = args.buf
--   --   local client = vim.lsp.get_client_by_id(args.data.client_id)
--   --   require("lsp-inlayhints").on_attach(client, bufnr)
--   -- end,
--
--   callback = function(args)
--     if vim.lsp.inlay_hint.is_enabled(args.bufnr) then
--       vim.lsp.inlay_hint.enable(true, bufnr)
--     end
--   end,
-- })

-- Prefer LSP folding if client supports it
-- else switch to  folding via treesitter or by syntax
vim.api.nvim_create_autocmd("LspAttach", {
  group = "lspconfigs",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    elseif require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   callback = function()
--     if require("nvim-treesitter.parsers").has_parser() then
--       vim.opt.foldmethod = "expr"
--       vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--     else
--       vim.opt.foldmethod = "syntax"
--     end
--   end,
-- })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- don't auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- Highlight trailing whitespace
-- vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "LightRed" })
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	command = [[
--     syntax clear TrailingWhitespace |
--     syntax match TrailingWhitespace "\_s\+$"
--   ]],
-- })
