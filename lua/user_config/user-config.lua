vim.cmd[[
set number             
set autoindent         
set shiftwidth=2       
set expandtab          
set splitright         
set clipboard=unnamed,unnamedplus 
set hls                
inoremap <silent> jj <ESC>
set list    
tnoremap <Esc> <C-\><C-n>  
noremap  <A-k> <C-w>W 
inoremap <A-k> <Esc><C-w>W
tnoremap <A-k> <C-\><C-n><C-w>W
noremap  <A-o> <C-w>o
inoremap <A-o> <Esc><C-w>o
tnoremap <A-o> <C-\><C-n><C-w>o
noremap  <A-;> :
inoremap <A-;> <Esc><C-o>:
tnoremap <A-;> <C-\><C-n><C-w>:
noremap  <A-/> /
inoremap <A-/> <Esc><C-o>/
tnoremap <A-/> <C-\><C-n>/
set ignorecase smartcase
]]

-- local function map(mode, lhs, rhs, opts)
--   local options = {noremap = true}
--   if opts then options = vim.tbl_extend('force', options, opts) end
--   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

local M = {}
return M 
