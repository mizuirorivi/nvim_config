-- Profile resolution shared by every platform.
--
-- Priority:
--   1. $NVIM_PROFILE  ("light" or "full")
--   2. <config>/.profile  (first non-empty line, "light" or "full")
--   3. "full"
--
-- The marker file is git-ignored, so each machine can pick its own default
-- without touching the repository. Plain `nvim` then works identically on
-- Linux, macOS and Windows (no shell-specific env syntax required).
local M = {}

local function normalize(value)
  if not value then
    return nil
  end
  value = tostring(value):gsub("%s+", ""):lower()
  if value == "light" or value == "full" then
    return value
  end
  return nil
end

local function from_env()
  return normalize(vim.env.NVIM_PROFILE)
end

local function from_marker()
  local marker = vim.fs.joinpath(vim.fn.stdpath("config"), ".profile")
  if vim.fn.filereadable(marker) ~= 1 then
    return nil
  end
  local ok, lines = pcall(vim.fn.readfile, marker)
  if not ok or type(lines) ~= "table" then
    return nil
  end
  for _, line in ipairs(lines) do
    local name = normalize(line)
    if name then
      return name
    end
  end
  return nil
end

M.name = from_env() or from_marker() or "full"
M.is_light = M.name == "light"

vim.g.nvim_profile = M.name

vim.api.nvim_create_user_command("Profile", function()
  local marker = vim.fs.joinpath(vim.fn.stdpath("config"), ".profile")
  vim.notify(
    ("Neovim profile: %s\n\nSwitch with:\n  $NVIM_PROFILE=light|full nvim\nor write \"light\"/\"full\" in:\n  %s")
      :format(M.name, marker),
    vim.log.levels.INFO
  )
end, { desc = "Show the active Neovim profile" })

return M
