-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
return {
  -- plugins that are dependencies
  "williamboman/mason.nvim",
  "nvim-lua/plenary.nvim",
  "lewis6991/impatient.nvim",

  -- UI plugins
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      window = {
        blend = 0,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    -- ---@module "ibl"
    -- ---@type ibl.config
    -- opts = {},
  },
  "MunifTanjim/nui.nvim",
  "nvim-lualine/lualine.nvim",
  "folke/tokyonight.nvim",
  { "catppuccin/nvim", name = "catppuccin", },

  -- language
	{
		"ray-x/go.nvim",
		dependencies = {  -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = {"CmdlineEnter"},
		ft = {"go", 'gomod'},
		build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
	},

  -- debugging
  -- Debug adapter plug-in. Debug anything in Neovim
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set("n", "<leader>d<space>", ":DapContinue<CR>")
      vim.keymap.set("n", "<leader>dl", ":DapStepInto<CR>")
      vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>")
      vim.keymap.set("n", "<leader>dh", ":DapStepOut<CR>")
      vim.keymap.set("n", "<leader>dz", ":ZoomWinTabToggle<CR>")
      vim.keymap.set(
          "n",
          "<leader>dgt",  -- dg as in debu[g] [t]race
          ":lua require('dap').set_log_level('TRACE')<CR>"
      )
      vim.keymap.set(
          "n",
          "<leader>dge",  -- dg as in debu[g] [e]dit
          function()
              vim.cmd(":edit " .. vim.fn.stdpath('cache') .. "/dap.log")
          end
      )
      vim.keymap.set("n", "<F1>", ":DapStepOut<CR>")
      vim.keymap.set("n", "<F2>", ":DapStepOver<CR>")
      vim.keymap.set("n", "<F3>", ":DapStepInto<CR>")
      vim.keymap.set(
          "n",
          "<leader>d-",
          function()
              require("dap").restart()
          end
      )
      vim.keymap.set(
          "n",
          "<leader>d_",
          function()
              require("dap").terminate()
              require("dapui").close()
          end
      )
    end,
    lazy = true,
  },

  -- A default "GUI" front-end for nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()

    -- Note: Added this <leader>dd duplicate of <F5> because somehow the <F5>
    -- mapping keeps getting reset each time I restart nvim-dap. Annoying but whatever.
    --
    vim.keymap.set(
      "n",
      "<leader>dd",
      function()
          require("dapui").open()  -- Requires nvim-dap-ui

          vim.cmd[[DapContinue]]  -- Important: This will lazy-load nvim-dap
      end
    )
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  -- Remember nvim-dap breakpoints between sessions, ``:PBToggleBreakpoint``
  {
    "Weissle/persistent-breakpoints.nvim",
    config = function()
      require("persistent-breakpoints").setup{
        load_breakpoints_event = { "BufReadPost" }
      }
      vim.keymap.set("n", "<leader>db", ":PBToggleBreakpoint<CR>")
    end,
  },

  -- LSP related
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "towolf/vim-helm", ft = "helm" },
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

  -- file management
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x"
  },
  "echasnovski/mini.files",
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },

  -- Other plugins
  "folke/zen-mode.nvim",
  -- 'tpope/vim-sleuth',
  'mhartington/formatter.nvim',
  "folke/which-key.nvim",
  "nvim-telescope/telescope.nvim",
  -- "jose-elias-alvarez/null-ls.nvim",
  "phaazon/hop.nvim",
  "towolf/vim-helm",
  "someone-stole-my-name/yaml-companion.nvim",
	"nvim-neorg/neorg",
	"kevinhwang91/nvim-bqf",
  "otavioschwanck/arrow.nvim",
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- text manipulation
  "windwp/nvim-autopairs",
  "numToStr/Comment.nvim",
  "folke/todo-comments.nvim",
  { 'echasnovski/mini.surround', version = '*' },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
			}
	},

  -- plugins for Lua
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

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

  { "jvgrootveld/telescope-zoxide", dependencies = { "jvgrootveld/telescope-zoxide", }, },

  -- { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets", },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },

  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
        require'window-picker'.setup()
    end,
  },

  -- Git related plugins
  -- 'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'APZelos/blamer.nvim',
  'sindrets/diffview.nvim',
  'akinsho/git-conflict.nvim',
	"TimUntersberger/neogit",
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { "<leader>ll", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
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
