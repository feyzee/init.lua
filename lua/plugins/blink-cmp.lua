-- local appearance = require("blink.cmp.config.appearance")

local completion_kinds = {
	Array = " ",
	Boolean = "󰨙 ",
	Class = " ",
	Codeium = "󰘦 ",
	Color = " ",
	Control = " ",
	Collapsed = " ",
	Constant = "󰏿 ",
	Constructor = " ",
	Copilot = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Key = " ",
	Keyword = " ",
	Method = "󰊕 ",
	Module = " ",
	Namespace = "󰦮 ",
	Null = " ",
	Number = "󰎠 ",
	Object = " ",
	Operator = " ",
	Package = " ",
	Property = " ",
	Reference = " ",
	Snippet = "󱄽 ",
	String = " ",
	Struct = "󰆼 ",
	Supermaven = " ",
	TabNine = "󰏚 ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = "󰀫 ",
}

return {
	"saghen/blink.cmp",
	version = "1.*",

	opts_extend = {
		"sources.completion.enabled_providers",
		"sources.compat",
		"sources.default",
	},

	dependencies = {
		{
			"saghen/blink.compat",
			optional = true, -- make optional so it's only enabled if any extras need it
			opts = {},
			version = not vim.g.lazyvim_blink_main and "*",
		},
	},

	event = { "InsertEnter", "CmdlineEnter" },

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = completion_kinds,
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },

		keymap = {
			preset = "default",
			["<A-]>"] = { "snippet_forward", "fallback" },
			["<A-[>"] = { "snippet_backward", "fallback" },

			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		-- Disable cmdline
		cmdline = { enabled = true },

		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},

			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			ghost_text = { enabled = true },
			keyword = { range = "full" },

			list = {
				max_items = 25,
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},

			menu = {
				auto_show = true,
				-- border = "single",
				min_width = 20,
				max_height = 15,

				-- nvim-cmp style menu
				draw = {
					snippet_indicator = "~",
					padding = { 0, 1 },
					treesitter = { "lsp" },

					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},

					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
						kind = {
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
		},

		sources = {
			compat = {},
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			min_keyword_length = 4,

			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},

			providers = {
				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					score_offset = 15, -- the higher the number, the higher the priority
				},

				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 101,
				},

				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					max_items = 7,
					min_keyword_length = nil,
					score_offset = 100,
				},

				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,
					fallbacks = { "snippets", "buffer" },
					max_items = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						ignore_root_slash = false,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},

				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 5,
					module = "blink.cmp.sources.snippets",
					score_offset = 75,

					opts = {
						use_show_condition = true,
						show_autosnippets = true,
						prefer_doc_trig = false,
						use_label_description = false,
					},
				},
			},
		},

		-- Use a preset for snippets, check the snippets documentation for more information
		snippets = { preset = "luasnip" },

		-- Experimental signature help support
		signature = { enabled = true },
	},
}
