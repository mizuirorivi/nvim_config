-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.is_open = false
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  hijack_directories = {
    enable = true, auto_open = false,
  }
})
function is_current_buffer_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  return buftype == '' and bufname ~= ''
end

function mytreetoggle()
  local log = require("usermod.mynotify").new("treelog", vim.log.levels.INFO)
  if vim.g.is_open then
    log:onlysave('NvimTree is already opened')
    vim.cmd('NvimTreeClose')
    vim.g.is_open = false
    return
  end
  vim.cmd('NvimTreeToggle')
  vim.g.is_open = not vim.g.is_open
  if is_current_buffer_file() then
    log:onlysave('current buffer is file')
    vim.cmd('NvimTreeFindFile')
    return
  end
  log:onlysave('current buffer is not file')
end

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

require('nvim-treesitter.configs').setup {
  root_dirs = { ".git", "package.json", ".root" },
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- other configuration options
}
