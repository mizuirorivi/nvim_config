-- fzf config
require('fzf-lua').setup({
  files = {
    fd_opts = "--type f --hidden --follow --exclude .git --no-ignore",
    rg_opts = "--files --hidden --follow -g '!.git'",
    find_opts = "-type f",
    -- Add Makefile to the list of recognized file types
    file_ignore_patterns = {"^.git/", "^node_modules/", "^vendor/"},
  },
})
--vim.cmd[[
-- nnoremap <c-P> <cmd>lua require('fzf-lua').files({prompt="LS> ",cwd=vim.fn.getcwd()})<CR>
-- nnoremap <c-F> <cmd>lua require('fzf-lua').grep()<CR>
--]]

-- function _G.fzf_file()
--   if vim.g.pwd == nil then
--     tabbylog:onlysave('vim.g.pwd is nil and cwd is ' .. vim.fn.getcwd())
--     vim.g.pwd = vim.fn.getcwd()
--   else 
--     tabbylog:onlysave('vim.g.pwd is ' .. vim.g.pwd)
--   end
  
--   vim.api.nvim_set_current_dir(vim.g.pwd)
-- end

vim.api.nvim_set_keymap('n', '<C-P>', "<cmd>lua require('fzf-lua').files({prompt='LS> ',cwd=vim.fn.getcwd()})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-F>', "<cmd>lua require('fzf-lua').grep()<CR>", { noremap = true, silent = true })
