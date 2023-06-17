function requirePath(path) 
  local files = io.popen('find "$HOME"/.config/nvim/lua/' .. path .. ' -type f')
  for file in files:lines() do  
    local req_file = file:gmatch('%/lua%/(.+).lua$'){0}:gsub('/', '.')
    status_ok, err = pcall(require, req_file)

     if not status_ok then
       vim.notify('Failed loading ' .. req_file .. err, vim.log.levels.DEBUG)
    end
  end
end


requirePath('user_config')
require 'plugins.init'
requirePath('plugins')

vim.cmd[[
 set termguicolors
 set undolevels=200
]]

require "colorscheme"

vim.cmd[[
  let g:python3_host_prog = '/usr/bin/python'
  map <CS-c> "+y
  map <CS-v> "+p
]]
