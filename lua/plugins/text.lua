local M = {}

---@param opts conform.setupOpts
function M.setup(_, opts)
	for _, key in ipairs({ "format_on_save", "format_after_save" }) do
		if opts[key] then
			local msg =
				"Don't set `opts.%s` for `conform.nvim`.\n**LazyVim** will use the conform formatter automatically"
			LazyVim.warn(msg:format(key))
			---@diagnostic disable-next-line: no-unknown
			opts[key] = nil
		end
	end
	---@diagnostic disable-next-line: undefined-field
	if opts.format then
		LazyVim.warn("**conform.nvim** `opts.format` is deprecated. Please use `opts.default_format_opts` instead.")
	end
	require("conform").setup(opts)
end

return {
	{ "mhartington/formatter.nvim" },

	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			enable_check_bracket_line = false,
			ignored_next_char = "[%w%.]",
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	{
		"folke/todo-comments.nvim",
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},

	{
		"nvim-mini/mini.surround",
		-- keys = function(_, keys)
		--   -- Populate the keys based on the user's options
		--   local opts = LazyVim.opts("mini.surround")
		--   local mappings = {
		--     { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "x" } },
		--     { opts.mappings.delete, desc = "Delete Surrounding" },
		--     { opts.mappings.find, desc = "Find Right Surrounding" },
		--     { opts.mappings.find_left, desc = "Find Left Surrounding" },
		--     { opts.mappings.highlight, desc = "Highlight Surrounding" },
		--     { opts.mappings.replace, desc = "Replace Surrounding" },
		--     { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
		--   }
		--   mappings = vim.tbl_filter(function(m)
		--     return m[1] and #m[1] > 0
		--   end, mappings)
		--   return vim.list_extend(mappings, keys)
		-- end,
		-- opts = {
		--   mappings = {
		--     add = "gsa", -- Add surrounding in Normal and Visual modes
		--     delete = "gsd", -- Delete surrounding
		--     find = "gsf", -- Find surrounding (to the right)
		--     find_left = "gsF", -- Find surrounding (to the left)
		--     highlight = "gsh", -- Highlight surrounding
		--     replace = "gsr", -- Replace surrounding
		--     update_n_lines = "gsn", -- Update `n_lines`
		--   },
		-- },
	},

	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
	},
}
