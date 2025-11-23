-- Create augroups once for better performance
local lsp_attach_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
local lsp_highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
local lsp_detach_group = vim.api.nvim_create_augroup("lsp-detach", { clear = false })

-- LSP related
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_attach_group,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- Enable inlay hints if supported
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

      vim.keymap.set("n", "<leader>cl", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end, { desc = "Toggle Inlay Hints" })
    end

    -- Enable document highlight if supported
    if client:supports_method("textDocument/documentHighlight") then
      -- Clear existing highlight autocmds for this buffer to prevent duplication
      vim.api.nvim_clear_autocmds({ group = lsp_highlight_group, buffer = event.buf })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = lsp_highlight_group,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = lsp_detach_group,
        buffer = event.buf,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = lsp_highlight_group, buffer = event2.buf })
        end,
      })
    end

    -- Enable codelens if supported
    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh({ bufnr = event.buf })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = event.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = event.buf })
        end,
      })
    end

    -- Prefer LSP folding if client supports it
    if client:supports_method("textDocument/foldingRange") then
      vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- Disable semantic tokens for large files
    if vim.api.nvim_buf_line_count(event.buf) > 5000 then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
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

-- show cursorline only in active window
local cursorline_group = vim.api.nvim_create_augroup("active_cursorline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
