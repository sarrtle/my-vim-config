local M = {}

M.base46 = {
	theme = "solarized_osaka",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.mason = {
  cmd = true,
  pkgs = {
    -- For python
    "basedpyright",
    "mypy",
    "pylint",
    "black",
    -- For Web Development
    "typescript-language-server",
    "tailwindcss-language-server",
    "prettierd",
    "emmet-language-server"
  }
}

return M
