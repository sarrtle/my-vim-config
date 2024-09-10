return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
    },
  },

  -- In order to modify the `lspconfig` configuration:
  {
    "neovim/nvim-lspconfig",
    config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
    end,
  },

  -- Install all required language syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require("nvchad.configs.treesitter")
      opts.ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css"
      }
    end
  },

  -- Null LS
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end
  },

  -- Auto close tag for jsx, tsx
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }
}
