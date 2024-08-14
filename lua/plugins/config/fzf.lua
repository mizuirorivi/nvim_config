-- fzf config
vim.cmd[[
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <c-F> <cmd>lua require('fzf-lua').grep()<CR>
]]
