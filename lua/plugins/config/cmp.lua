local completion_menu = {
  nvim_lsp = '[LSP]',
  buffer = '[﬘]',
  path = '[]',
  spell = '[﬜]',
}

local completion_kind = {
  Text = ' (text)',
  Method = ' (method)',
  Function = ' (function)',
  Constructor = ' (constructor)',
  Field = 'ﰠ (field)',
  Variable = ' (variable)',
  Class = ' (class)',
  Interface = ' (interface)',
  Module = ' (module)',
  Property = ' (property)',
  Unit = ' (unit)',
  Value = ' (value)',
  Enum = ' (enum)',
  Key = ' (key)',
  Snippet = '﬌ (snippet)',
  Color = ' (color)',
  File = ' (file)',
  Reference = ' (reference)',
  Folder = ' (folder)',
  EnumMember = ' (enum member)',
  Constant = ' (constant)',
  Struct = ' (struct)',
  Event = ' (event)',
  Operator = ' (operator)',
  TypeParameter = ' (type)',
}

local cmp = require'cmp'

return ({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = { -- TODO: check the formatter
    format = function(entry, vim_item)
      vim_item.menu = completion_menu[entry.source.name]
      vim_item.kind = completion_kind[vim_item.kind]
      vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
      return vim_item
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'nvim_lsp_signature_help' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
      keyword_length = 5,
    },
  },

  experimental = {
    -- native_menu = false,
    ghost_text = true,
  },
})
