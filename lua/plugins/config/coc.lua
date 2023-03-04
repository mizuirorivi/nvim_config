vim.cmd[[
  vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  nmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  
  " Format action on <leader>f
  vmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  " Goto definition
  nmap <silent> gd <Plug>(coc-definition)
  " Open definition in a split window
  nmap <silent> gv :vsp<CR><Plug>(coc-definition)<C-W>L
  " defenetion global variable using let
  let g:coc_config_home = expand('~/.config/nvim/coc-settings.json')
]]
