vim.cmd[[
  map <C-b> :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1
]]
vim.cmd[[
  autocmd BufEnter NERD_tree_* | execute 'normal R'
  let g:NERDTreeHijackNetrw = 1
  au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
]]
