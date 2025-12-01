-- Create augroups once for better performance
local LspAttachGroup = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
local LspHighlightGroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })

-- LSP related
vim.api.nvim_create_autocmd("LspAttach", {
  group = LspAttachGroup,
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- Enable inlay hints if supported
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

      vim.keymap.set("n", "<leader>cl", function()
        vim.lsp.inlay_hint.enable(not
          vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
          { bufnr = event.buf }
        )
      end, { desc = "Toggle Inlay Hints", buffer = event.buf })
    end

    -- Enable document highlight if supported
    if client:supports_method("textDocument/documentHighlight") then
      -- Clear existing highlight autocmds for this buffer to prevent duplication
      -- if multiple clients attach to the same buffer
      vim.api.nvim_clear_autocmds({ group = LspHighlightGroup, buffer = event.buf })
      local last_highlight = {}

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = LspHighlightGroup,
        -- callback = vim.lsp.buf.document_highlight,
        callback = function()
          local current_pos = vim.api.nvim_win_get_cursor(0)
          local pos_key = current_pos[1] .. ":" .. current_pos[2]
          -- Only highlight if position changed
          if last_highlight[event.buf] ~= pos_key then
            vim.lsp.buf.document_highlight()
            last_highlight[event.buf] = pos_key
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = LspHighlightGroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Prefer LSP folding if client supports it
    if client:supports_method("textDocument/foldingRange") then
      vim.api.nvim_set_option_value("foldmethod", "expr", { buf = event.buf })
      vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { buf = event.buf })
    end

    -- Disable semantic tokens for large files
    if vim.api.nvim_buf_line_count(event.buf) > 5000 then
      -- client.server_capabilities.semanticTokensProvider = nil
      vim.lsp.semantic_tokens.stop(event.buf, client.id)
    end
  end,
})

-- Do cleanup when LspDetach event occurs
vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("LspDetach", { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
    pcall(vim.api.nvim_clear_autocmds, { group = LspHighlightGroup, buffer = event.buf })
    pcall(vim.lsp.inlay_hint.enable, false, { bufnr = event.buf })

    if vim.api.nvim_get_option_value("foldexpr", { buf = event.buf }) == "v:lua.vim.lsp.foldexpr()" then
      vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { buf = event.buf })
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

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    local exclude_ft = { "gitcommit", "gitrebase", "help" }
    local buf_ft = vim.bo[args.buf].filetype

    if vim.tbl_contains(exclude_ft, buf_ft) then
      return
    end

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

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("AutoResize", { clear = true }),
  command = "wincmd =",
})

-- Don't auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NoAutoComment", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Show cursorline only in active window
local cursorline_group = vim.api.nvim_create_augroup("ActiveCursorline", { clear = true })
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
