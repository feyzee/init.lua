-- local default_theme = { fg = "#FF0000", bg = "None" }

return {
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
    disabled_filetypes = {'mason', 'lazy', 'NvimTree', 'neo-tree'},
  },
  sections = {
    lualine_a = {
      -- { 'mode', right_padding = 2 },
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {{'filename', path = 1}, {'branch'}},
    lualine_c = {'diagnostics', 'diff'},
    lualine_x = {'selectioncount', 'encoding','fileformat'},
    lualine_y = {'filetype','progress'},
    lualine_z = {
      -- { 'location', left_padding = 2 },
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
