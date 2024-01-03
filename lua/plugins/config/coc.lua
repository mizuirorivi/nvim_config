vim.cmd[[
  vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  nmap <leader>a <Plug>(coc-codeaction-selected)<CR>
  
  " Format action on <leader>f
  vmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  " Goto float window
  imap <leader>gm <Plug>(coc-float-jump)
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
  let g:coc_config_home = expand('~/.config/nvim')
]]

vim.api.nvim_create_autocmd("FileType",{
  pattern = "rust",
  callback = function()
    vim.api.nvim_buf_set_keymap(0,"n","<leader>r","<Cmd>CocCommand rust-analyzer.run<CR>",{
      noremap = true,
      silent = true
    })
  end
})

vim.keymap.set(
  'i',
  '<CR>',
  function ()
    if vim.fn['coc#pum#visible']() == 1 then
      return vim.fn['coc#pum#confirm']()
    else
      return "<CR>"
    end
  end,
  { expr = true }
)
