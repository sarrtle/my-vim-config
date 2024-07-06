require "nvchad.options"

-- add yours here!

-- colorizer
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

-- Override LSP diagnostics handler to filter Pyright diagnostics
local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
    local diagnostics = result.diagnostics
    if diagnostics then
        local new_diagnostics = {}
        for _, diagnostic in ipairs(diagnostics) do
            if not (diagnostic.source and diagnostic.source:find("Pyright")) then
                table.insert(new_diagnostics, diagnostic)
            end
        end
        result.diagnostics = new_diagnostics
    end
    default_handler(_, result, ctx, _)
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
