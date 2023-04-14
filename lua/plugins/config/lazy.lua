-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local M = {}

M.plugins = {
  "williamboman/mason.nvim",
  "nvim-lua/plenary.nvim",
  'lewis6991/impatient.nvim',

  {
    'j-hui/fidget.nvim',
    opts = {
      window = {
        blend = 0,
      },
    },
  },

  -- LSP related
  "neovim/nvim-lspconfig",
  'williamboman/mason-lspconfig.nvim',
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },


  -- Other plugins
  'nvim-lualine/lualine.nvim',
  "numToStr/Comment.nvim",
  'tpope/vim-sleuth',
  'mhartington/formatter.nvim',
  'nvim-tree/nvim-web-devicons',
  "lukas-reineke/indent-blankline.nvim",
  "windwp/nvim-autopairs",
  "folke/which-key.nvim",
  "nvim-tree/nvim-tree.lua",
  'folke/neodev.nvim',
  "nvim-telescope/telescope.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "folke/tokyonight.nvim",
  "folke/trouble.nvim",
  "rmagatti/auto-session",
  "phaazon/hop.nvim",

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    "jvgrootveld/telescope-zoxide",
    dependencies = {
      "jvgrootveld/telescope-zoxide",
    },
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'APZelos/blamer.nvim',
  'sindrets/diffview.nvim',
  'akinsho/git-conflict.nvim',

  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
  },
}

M.options = {
  defaults = { lazy = true },

  ui = {
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

return M
