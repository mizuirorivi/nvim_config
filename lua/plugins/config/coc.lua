vim.cmd[[
  vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  nmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  
  " Format action on <leader>foc
  vmap <leader>foc  <Plug>(coc-format-selected)
  nmap <leader>foc  <Plug>(coc-format-selected)
  " Goto definition
  nmap <silent> gd <Plug>(coc-definition)
  " Goto type definition
  nmap <silent> gy <Plug>(coc-type-definition)
  " Goto implementation
  nmap <silent> gi <Plug>(coc-implementation)
  " Goto references
  nmap <silent> gr <Plug>(coc-references)
  " Open definition in a split window
  nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
  " defenetion global variable using let
  let g:coc_config_home = expand('~/.config/nvim/coc-settings.json')
]]
