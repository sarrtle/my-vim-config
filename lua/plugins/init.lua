return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Install all required language syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
      },
    },
  },

  -- Auto close tag for jsx, tsx
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Markdown plugin
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    ft = "markdown",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local markview = require "markview"
      local presets = require "markview.presets"

      markview.setup {
        checkboxes = presets.checkboxes.nerd,
      }
    end,
  },

  -- Neocodeium plugin
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      require("neocodeium").setup {
        silent = true,
        filetypes = {
          -- manual control of all possible filetypes
          -- add more if needed
          lua = true,
          python = true,
          javascript = true,
          javascriptreact = true,
          typescript = true,
          typescriptreact = true,
          text = false,
          markdown = false,
          json = false,
          yaml = false,
          -- I don't know why the rest of the filetypes
          -- are not disabling after putting false to
          -- all rest of filetypes
          ["."] = false,
        },
      }
    end,
  },
}
