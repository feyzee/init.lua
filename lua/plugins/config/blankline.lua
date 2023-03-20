local M = {}

M = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "mason",
    "",
  },
  buftype_exclude = { "terminal" },
  char = '┊',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_end_of_line = true,
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
}

return M
