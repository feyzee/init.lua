return {
  "nvim-lualine/lualine.nvim",

  opts = {
    options = {
      -- theme = {
      --   normal = {
      --     a = default_theme,
      --     b = default_theme,
      --     c = default_theme,
      --     x = default_theme,
      --     y = default_theme,
      --     z = default_theme,
      --   },
      --   inactive = {
      --     a = default_theme,
      --     b = default_theme,
      --     c = default_theme,
      --     x = default_theme,
      --     y = default_theme,
      --     z = default_theme,
      --   },
      -- },
      theme = 'tokyonight',
      component_separators = '|',
      section_separators = { left = '', right = '' },
      disabled_filetypes = { 'mason', 'lazy', 'NvimTree', 'neo-tree' },
    },
    sections = {
      lualine_a = {
        -- { 'mode', right_padding = 2 },
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },

      lualine_b = { { 'filename', path = 1 }, { 'branch' } },
      lualine_c = { 'diagnostics', 'diff' },
      lualine_x = { 'selectioncount', 'encoding', 'fileformat' },
      lualine_y = {
        'filetype',
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
          -- icon = ' ',
        },
        'progress'
      },

      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },

    inactive_sections = {
      lualine_a = { { 'filename', file_status = true, path = 1 } },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { { 'branch' }, { 'location' } },
    },

    tabline = {},
    extensions = {},
  },
}
