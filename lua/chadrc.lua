-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  -- hl_override = {
  -- Comment = { italic = true },
  -- ["@comment"] = { italic = true },
  -- },
}

M.ui = {
  statusline = {
    theme = "vscode",
    -- warning: Always check the order if things are updated in
    -- https://github.com/NvChad/base46/blob/v3.0/lua/base46/statusline.lua
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "neocodeium", "lsp", "cursor", "cwd" },
    modules = {
      neocodeium = function()
        return require("configs.neocodeium_config").status .. " "
      end,
    },
  },
}

M.mason = {
  pkgs = {
    -- For python
    "pyright",
    "black",
  },
}

return M
