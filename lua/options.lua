require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- fix 'no information available' on hover if no result and empty markdowns
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method

  if not (result and result.contents) then
    return
  end

  local markdown_lines = vim.split(result.contents.value, "\n", { trimempty = false })

  if vim.tbl_isempty(markdown_lines) then
    return
  end

  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

-- replace cmd to powershell and automatically activate
-- virtual virtual enviroment of python in windows
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "pwsh.exe"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = '"'
  vim.opt.shellxquote = ""
end

-- Realtime update of diagnostic list
vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
  callback = function()
    -- Check if the location list is open by examining its winid
    -- If the location list is open, update the diagnostic list
    local loclist_info = vim.fn.getloclist(0, { winid = 0 })
    if loclist_info.winid ~= -1 then
      -- check if the current buffer is active and valid
      -- If I don't do this, this callback will still try
      -- to run this code even there is no buffer and raising
      -- some error
      local bufnr = vim.api.nvim_get_current_buf()

      if vim.api.nvim_buf_is_loaded(bufnr) then
        vim.diagnostic.setloclist { open = false }
      end
    end
  end,
})

-- neocodeium event listeners
require("configs.neocodeium_config").setup_listeners()
-- Automatic statusline update for supported filetypes
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local event = require "neocodeium.events"
    local filetypes = require("configs.neocodeium_config").filetypes
    local current_buffer = vim.bo.filetype
    if vim.tbl_contains(filetypes, current_buffer) then
      event.emit "NeoCodeiumBufEnabled"
    else
      event.emit "NeoCodeiumBufDisabled"
    end
  end,
})
