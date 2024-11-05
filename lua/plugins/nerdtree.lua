-- functions
-- defnition global variables
vim.g.isopenednerdtree = 0


local nerdlog = require("usermod.mynotify").new("NERDLOG", vim.log.levels.INFO)
function FindClosedRoot(path)
  local root = path
  while root ~= '' do
    if vim.fn.isdirectory(root .. '/.git') == 1 then
      return root
    end
    root = vim.fn.fnamemodify(root, ':h')
  end
  return ''
end

function SetNERDTreeRootToNearestGit()
  local r = require('nvim-rooter').get_root()
  nerdlog:onlysave(r)

  if vim.g.isopenednerdtree == 1 then
    vim.cmd('NERDTreeClose')
    vim.g.isopenednerdtree = 0
    return
  end
  root = vim.fn.expand('%:p:h')
  git_root = FindClosedRoot(root)
  nerdlog:onlysave(git_root)

  if git_root == '' then
    nerdlog:onlysave('No git root found')
    return
  end

  local current_win = vim.api.nvim_get_current_win()
  vim.cmd('NERDTreeClose')
  vim.cmd('cd ' .. git_root)
  vim.cmd('NERDTree')
  vim.cmd('NERDTreeCWD')
  vim.api.nvim_set_current_win(current_win)
  vim.cmd('NERDTreeFind')
  vim.g.isopenednerdtree = 1
end

-- set up global variables for nerdtree plugin
vim.g.NERDTreeFileLines = 1 
vim.g.NERDTreeHijackNetrw = 0
-- keymap settings

vim.api.nvim_set_keymap('n', '<C-b>', ':lua SetNERDTreeRootToNearestGit()<CR>', { noremap = true, silent = true })
-- adjust action 
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- ファイルやバッファが指定されていない場合のみ NERDTree を開かない
    if vim.fn.argc() == 0 and vim.fn.isdirectory(vim.fn.getcwd()) == 1 then
      return
    end
  end,
})
local wk = require("which-key")

wk.register({

  triggers = { "<space>" },
  r = {
    name = "NERDT(r)ee",
  }
}, { prefix = "<space>" })
