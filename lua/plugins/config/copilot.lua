vim.api.nvim_set_keymap('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.defer_fn(function()
  vim.cmd("Copilot enable")
  vim.cmd("Copilot status")
end, 10000)
