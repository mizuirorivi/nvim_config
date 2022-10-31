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

vim.api.nvim_set_option("clipboard","unnamed")
local M = {}
return M