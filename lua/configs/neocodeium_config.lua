-- neocodeium configurations
-- Edit status line and event bindings
-- configs/neocodeium_config.lua
local M = {}

-- State holder for statusline
M.status = ""

-- Update function for statusline
function M.UpdateStatusLine()
  return M.status
end

-- Setup event listeners
function M.setup_listeners()
  local events = {
    "NeoCodeiumServerConnecting",
    "NeoCodeiumServerConnected",
    "NeoCodeiumServerStopped",
    "NeoCodeiumEnabled",
    "NeoCodeiumDisabled",
    "NeoCodeiumBufEnabled",
    "NeoCodeiumBufDisabled",
    -- "NeoCodeiumCompletionDisplayed",
    -- "NeoCodeiumCompletionCleared",
  }

  -- Create autocommand group for all events
  local group = vim.api.nvim_create_augroup("NeoCodeiumStatusline", { clear = true })

  for _, event in ipairs(events) do
    vim.api.nvim_create_autocmd("User", {
      pattern = event,
      group = group,
      callback = function()
        -- Update status based on NeoCodeium state
        local ok, _ = pcall(require, "neocodeium")
        if not ok then
          M.status = "󰚩 Check NeoCodeium installation"
          return
        end

        -- Customize status based on events
        if event == "NeoCodeiumServerConnecting" then
          M.status = "󰚩 Codeium Connecting..."
        elseif event == "NeoCodeiumServerConnected" or event == "NeoCodeiumBufEnabled" then
          M.status = "󰚩 Codeium" -- Server connected icon
        elseif event == "NeoCodeiumServerStopped" then
          M.status = "󰚩 Codeium Unavailable" -- Server stopped icon
        elseif event == "NeoCodeiumBufDisabled" then
          -- I don't know why disabled buffer are not detected even
          -- they have been setup to false in filetypes, in plugins/init.lua
          -- it seems that this event it only called if the function: require("neocodeium.commands").disable_buffer()
          -- one way to fix this is to check the extension of the buffer and disable them if detected from neocodeium
          -- filetypes
          M.status = ""
        end

        -- Force statusline refresh
        vim.schedule(function()
          vim.cmd "redrawstatus"
        end)
      end,
    })
  end
end

return M
