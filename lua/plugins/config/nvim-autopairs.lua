-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

return {
  fast_wrap = {},
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
  disable_filetype = { "TelescopePrompt", "vim" },
}
