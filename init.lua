
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
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.chdir(vim.fn.getcwd()) -- シェルのCWDを明示的に設定
  end,
})
-- desc を捕捉・注入するラッパー（プラグインより先に設定）
_G._cmd_descs = {}

local _orig_create_cmd = vim.api.nvim_create_user_command
vim.api.nvim_create_user_command = function(name, cmd, opts)
  if opts and opts.desc then
    _G._cmd_descs[name] = opts.desc
  end
  return _orig_create_cmd(name, cmd, opts)
end

local _orig_get_commands = vim.api.nvim_get_commands
vim.api.nvim_get_commands = function(opts)
  local result = _orig_get_commands(opts)
  for name, desc in pairs(_G._cmd_descs) do
    if result[name] then
      result[name].desc = desc
    end
  end
  return result
end

local _orig_buf_get_commands = vim.api.nvim_buf_get_commands
vim.api.nvim_buf_get_commands = function(buf, opts)
  local result = _orig_buf_get_commands(buf, opts)
  for name, desc in pairs(_G._cmd_descs) do
    if result[name] then
      result[name].desc = desc
    end
  end
  return result
end

require('usermod.notify_intercept')
require('usermod.treesitter_fix')
local requirePath = require("usermod.require_path").requirePath
requirePath('config')
requirePath('user_config')
requirePath('plugins')
requirePath('colorscheme')
requirePath('plugins/language')
require('usermod.command_search')
require('usermod.tab_switcher')
require('usermod.lsp_diagnostics')
require "colorscheme"

vim.cmd[[
  let g:python3_host_prog = '/usr/bin/python'
  map <CS-c> "+y
  map <CS-v> "+p
]]


