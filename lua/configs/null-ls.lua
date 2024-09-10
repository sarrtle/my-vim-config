local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Get python version for dynamic version used
local function get_python_version()
  local handle = io.popen("python --version")
  local result = handle:read("*a")
  handle:close()
  return result:match("(%d+%.%d+)"):gsub("%.", "")
end

-- Get environment path for specific system
local function get_vertual_env_paths()
  local sysname = vim.loop.os_uname().sysname
  local python_version = get_python_version()

  -- for linux
  if sysname == "Linux" then
    local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    return virtual .. "/bin/python" .. python_version:sub(1, 1) -- get only the major version (eg. 3)

  -- for windows
  else
    local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    -- with or without virtual environment
    if not virtual then
      virtual = os.getenv("USERPROFILE") .. "/appdata/local/programs/python/python" .. python_version
      return virtual .. "/python"
    else
      return virtual .. "/scripts/python"
    end
  end
end

local opts = {
  sources = {
    -- PYTHON
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = function()
        return {
          "--check-untyped-defs",
          "--python-executable", get_vertual_env_paths(),
          "--explicit-package-bases", -- checking top level directory if __init__.py is missing
          "--cache-dir=/dev/null", -- disable the .mypy_cache but mypy will tend to slower for rerun without referencing old data
        }
      end
    }),
    null_ls.builtins.diagnostics.pylint.with({
      extra_args = {
        "-d E0401" -- temporary disable import error since mypy is already doing this and pylint doesn't really support virtual environment or hard to implement after hard research
      }
    }),

    -- WEB DEVELOPMENT
    null_ls.builtins.formatting.prettierd
  },

  -- AUTO FOMAT ON SAVE OPTION
  on_attach = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
}

return opts
