require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- enable disable inlay hint
map("n", "m", function()
  local is_enabled = vim.lsp.inlay_hint.is_enabled()
  vim.lsp.inlay_hint.enable(not is_enabled)
end, { desc = "Enable Disable inlay hints" })

-- Markdown mapping
map("n", "mm", function()
  require("markview").commands.toggle(vim.api.nvim_get_current_buf())
end, { desc = "Markview Toggle markdown preview" })
map("n", "md", function()
  require("markview").commands.splitToggle(vim.api.nvim_get_current_buf())
end, { desc = "Markview Toggle markdown split preview" })

-- aerial mappings
vim.keymap.set("n", "<C-a>", function()
  require("aerial").toggle { focus = false, direction = "right" }
end, { desc = "Aerial toggle" })
vim.keymap.set("n", "<C-b>", function()
  require("aerial").nav_toggle()
end, { desc = "Aerial nav toggle" })
