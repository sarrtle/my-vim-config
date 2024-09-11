require "nvchad.options"

-- add yours here!

-- add colors in tailwind on auto completion
require("colorizer").setup {
  filetypes = { "*" },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue or blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    AARRGGBB = false, -- 0xAARRGGBB hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = "background", -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = true, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
    virtualtext = "■",
    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = true
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}

-- fix 'no information available' on hover if no result and empty markdowns
vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method

  if not (result and result.contents) then
    return
  end

  local markdown_lines = vim.split(result.contents.value, '\n', {trimempty = false})

  if vim.tbl_isempty(markdown_lines) then
    return
  end

  return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end

-- replace cmd to powershell and automatically activate
-- virtual virtual enviroment of python in windows
if vim.loop.os_uname().sysname ~= "Linux" then
  local activation_command = ""
  if vim.env.VIRTUAL_ENV then
    activation_command = '-NoExit -Command "& {& $env:VIRTUAL_ENV/scripts/activate.ps1}"'
  else
    activation_command = '-NoExit -Command "clear"' -- No logo doesn't seem to work here
  end

  vim.o.shell = "powershell.exe"
  vim.o.shellcmdflag = activation_command
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end

-- Realtime update of diagnostic list
vim.api.nvim_create_autocmd({"DiagnosticChanged"}, {
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
        vim.diagnostic.setloclist({ open = false })
      end
    end
  end,
})
