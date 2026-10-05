local M = {}
local mynotify = require("usermod.mynotify").new({
  level = vim.log.levels.TRACE,
})

local lua_root = vim.fs.joinpath(vim.fn.stdpath("config"), "lua")

local function collect_lua_files(root)
  local files = {}

  local function walk(dir)
    local handle = vim.uv.fs_scandir(dir)
    if not handle then
      return
    end

    while true do
      local name, entry_type = vim.uv.fs_scandir_next(handle)
      if not name then
        break
      end

      local full_path = vim.fs.joinpath(dir, name)
      if entry_type == "directory" then
        walk(full_path)
      elseif entry_type == "file" and name:sub(-4) == ".lua" then
        files[#files + 1] = full_path
      end
    end
  end

  walk(root)
  table.sort(files)
  return files
end

function M.requirePath(path)
  local root = vim.fs.joinpath(lua_root, path)

  for _, file in ipairs(collect_lua_files(root)) do
    local relative = file:sub(#lua_root + 2):gsub("\\", "/")
    local module_name = relative:sub(1, -5):gsub("/", ".")
    local status_ok, err = pcall(require, module_name)
    if not status_ok then
      mynotify:my_notify("Error loading " .. module_name .. ": " .. err)
    end
  end
end

return M
