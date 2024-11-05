-- fzf config
vim.cmd[[
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <c-F> <cmd>lua require('fzf-lua').grep()<CR>
]]
require('fzf-lua').setup({
  files = {
    fd_opts = "--type f --hidden --follow --exclude .git --no-ignore",
    rg_opts = "--files --hidden --follow -g '!.git'",
    find_opts = "-type f",
    -- Add Makefile to the list of recognized file types
    file_ignore_patterns = {"^.git/", "^node_modules/", "^vendor/"},
  },
})
