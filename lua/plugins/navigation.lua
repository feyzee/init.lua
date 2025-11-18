return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
    }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "\\",         mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "<leader>\\", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<c-s>",      mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
      -- Simulate nvim-treesitter incremental selection
      {
        "<c-space>",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<BS>"] = "prev"
            }
          })
        end,
        desc = "Treesitter Incremental Selection"
      },
    },
  },
}
