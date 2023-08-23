return {
  ensure_installed = {
    "bash-language-server",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "gopls",
    "lua-language-server",
    "python-lsp-server",
    "terraformls",
    "tflint",
    "typescript-language-server",
    "yaml-language-server",
  },

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    -- TODO: move to mappings.lua
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}
