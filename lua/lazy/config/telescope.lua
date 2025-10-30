local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
-- local pickers = require('telescope.pickers')
-- local finders = require('telescope.finders')
-- local conf = require('telescope.config').values
-- local make_entry = require('telescope.make_entry')
local trouble = require("trouble.sources.telescope")

-- local M = {}

-- M.dotbare_picker = function(opts)
--   opts = opts or {}
--
--   opts.cwd = os.getenv('DOTBARE_TREE')
--   opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
--
--   pickers
--     .new(opts, {
--       prompt_title = 'Git Files',
--       finder = finders.new_oneshot_job({ 'dotbare', 'ls-files', '--full-name' }, opts),
--       previewer = conf.file_previewer(opts),
--       sorter = conf.file_sorter(opts),
--     })
--     :find()
-- end

local function smart_enter(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  if #picker:get_multi_selection() > 0 then
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd('copen')
  else
    actions.select_default(prompt_bufnr)
    actions.center()
  end
end

return {
  defaults = {
    file_ignore_patterns = {
      "node_modules"
    },
    sorting_strategy = 'descending',
    layout_config = { prompt_position = 'bottom' },
    prompt_prefix = ' ',
    selection_caret = '» ',
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ['<M-a>'] = actions.toggle_all,
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
        ['<CR>'] = smart_enter,
        ['<ESC>'] = actions.close,
        ["<C-t>"] = trouble.open,
      },
      n = {
        ["<C-p>"] = trouble.open_with_trouble,
      }
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
        },
        n = {
          ["d"] = actions.delete_buffer,
        },
      },
    },
    find_files = {
      find_command = {
        'fd', '--type', 'f', '--strip-cwd-prefix'
      },
    },
  },
  extensions = {
    zoxide = require("plugins.config.telescope-zoxide"),
  },
}
