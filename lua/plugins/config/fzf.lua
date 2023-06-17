-- fzf config
vim.cmd[[
nnoremap <c-P> <cmd>lua require('fzf-commands').files()<CR>
nnoremap <c-F> <cmd>lua require('fzf-commands').grep()<CR>
command! -nargs=1 Rg call luaeval('require("fzf-commands").rg(_A)', <f-args>)
nnoremap <c-F> :<c-u>Rg<space>
]]
