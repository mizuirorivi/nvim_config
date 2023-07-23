function requirePath(path) 
  local files = io.popen('find "$HOME"/.config/nvim/lua/' .. path .. ' -type f')

  for file in files:lines() do
    for req_file in file:gmatch('%/lua%/(.+).lua$') do
      req_file = req_file:gsub('/', '.')
      status_ok, _ = pcall(require, req_file)

      if not status_ok then
        vim.notify('Failed loading ' .. req_file, vim.log.levels.ERROR)
      end
    end
  end
end

requirePath('user_config')
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

