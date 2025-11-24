-- Included plugins in this module:
--   - lualine.nvim

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = "|",
      disabled_filetypes = { "mason", "lazy", "NvimTree", "neo-tree", "gitsigns-blame", "quickfix", "prompt" },
      globalstatus = true,
      section_separators = { left = "", right = "" },
      theme = "tokyonight",
    },
    sections = {
      lualine_a = {
        -- { "mode", right_padding = 2 },
        { "mode", separator = { left = "" }, right_padding = 2 },
      },

      lualine_b = { { "branch" } },
      lualine_c = { "diagnostics", "diff" },
      lualine_x = { "selectioncount", "encoding", "fileformat" },
      lualine_y = {
        "filetype",
        { -- Displays the attached LSPs
          function()
            local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
            if #buf_clients == 0 then
              return "No LSP"
            end
            local buf_client_names = {}
            for _, client in pairs(buf_clients) do
              table.insert(buf_client_names, client.name)
            end
            return table.concat(buf_client_names, ", ")
          end,
        },
        "progress",
      },

      lualine_z = {
        { "location", separator = { right = "" }, left_padding = 2 },
      },
    },

    inactive_sections = {
      lualine_a = { { "filename", file_status = true, path = 1 } },
      lualine_b = { "diagnostics", "diff" },
      lualine_c = {},
      lualine_x = { { "branch" }, { "fileformat" } },
      lualine_y = { -- Displays the attached LSPs
        function()
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if #buf_clients == 0 then
            return "No LSP"
          end
          local buf_client_names = {}
          for _, client in pairs(buf_clients) do
            table.insert(buf_client_names, client.name)
          end
          return table.concat(buf_client_names, ", ")
        end,
      },
      lualine_z = { "location" },
    },

    tabline = {
      lualine_a = {
        {
          "tabs",
          mode = 1, -- 0: Shows tab_name or new tab count if no name is set
          path = 0,
          max_length = vim.o.columns, -- Force full width to avoid truncation
          fmt = function(name, context)
            local tabnr = context.tabnr
            local tab_name = vim.fn.gettabvar(tabnr, "tab_name")
            if tab_name == "" then
              tab_name = nil
            end

            local buflist = vim.fn.tabpagebuflist(tabnr)
            local unique_bufs = {}
            for _, b in ipairs(buflist) do
              unique_bufs[b] = true
            end
            local count = 0
            for _ in pairs(unique_bufs) do
              count = count + 1
            end

            local display_name = tab_name or name
            return string.format("%d: %s (%d)", tabnr, display_name, count)
          end,
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        { "filename", path = 1 }, -- Show relative path of current buffer
      },
    },
    extensions = {},
  },
}
