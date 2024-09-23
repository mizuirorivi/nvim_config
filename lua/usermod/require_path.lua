local M = {}
local mynotify = require("usermod.mynotify").my_notify
function M.requirePath(path) 
  local files = io.popen('find "$HOME"/.config/nvim/lua/' .. path .. ' -type f')

  for file in files:lines() do
    for req_file in file:gmatch('%/lua%/(.+).lua$') do
      req_file = req_file:gsub('/', '.')
      local status_ok, f = pcall(require, req_file)
      if not status_ok then
        mynotify(f, vim.log.levels.TRACE)
      end
    end
  end
end
return M
