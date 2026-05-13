
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
local requirePath = require("usermod.require_path").requirePath
requirePath('config')
requirePath('user_config')
requirePath('plugins')
requirePath('colorscheme')
requirePath('plugins/language')
require('usermod.command_search')
require('usermod.relative_number')
require('usermod.tab_switcher')
require('usermod.lsp_diagnostics')
require "colorscheme"

vim.cmd[[
  let g:python3_host_prog = '/usr/bin/python'
  map <CS-c> "+y
  map <CS-v> "+p
]]


