local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
require('neo-root').setup {
      CUR_MODE = 2 -- 1 for file/buffer mode, 2 for proj-mode
}
vim.cmd'au BufEnter * NeoRoot'
vim.keymap.set('n', '<Leader>p', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
vim.keymap.set('n', '<Leader>pre', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
