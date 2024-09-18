
vim.cmd[[
  set termguicolors
  set undolevels=200
  set ffs=unix
  set encoding=utf-8
  set fileencoding=utf-8
  set listchars=eol:$
  set list
  nnoremap <leader>sv :source $MYVIMRC<CR>
]]

function requirePath(path) 
  local files = io.popen('find "$HOME"/.config/nvim/lua/' .. path .. ' -type f')

  for file in files:lines() do
    for req_file in file:gmatch('%/lua%/(.+).lua$') do
      req_file = req_file:gsub('/', '.')
      local status_ok, f = pcall(require, req_file)
      if not status_ok then
        my_notify(f, vim.log.levels.TRACE)
      end
    end
  end
end
function my_notify(message, vlevel)
  local status, notify = pcall(require, 'notify')
  if status then
    notify.setup({
      minimum_width = 20,
      background_colour = "#000000",
      render = "wrapped-compact",
    })
    option = {
      title = "Neovim CONFIG INFORMATION",
      level = vlevel,
      timeout =  0.1
    }
    notify.Option = option
    notify.notify(message,"info", option)
  else
    vim.notify(message, vim.log.levels.TRACE)
  end
end

requirePath('config')
requirePath('user_config')
requirePath('plugins')
requirePath('colorscheme')
require('usermod.command_search')
require('usermod.relative_number')
require('usermod.tab_switcher')
require "colorscheme"

vim.cmd[[
  let g:python3_host_prog = '/usr/bin/python'
  map <CS-c> "+y
  map <CS-v> "+p
]]

