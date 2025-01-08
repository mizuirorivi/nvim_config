-- functions
-- defnition global variables
vim.g.isopenednerdtree = 0



local nerdlog = require("usermod.mynotify").new("NERDLOG", vim.log.levels.INFO)
function SetNERDTreeRootToNearestGit()
  if vim.g.isopenednerdtree == 1 then
    vim.cmd('NERDTreeClose')
    vim.g.isopenednerdtree = 0
    return
  end
  local git_root = require("usermod.rootor.rooter"):new():FindClosedRoot()

  if git_root == '' or git_root == nil then
    nerdlog:onlysave('No git root found')
    vim.cmd('NERDTree ')
    vim.g.isopenednerdtree = 1
    return
  end
  nerdlog:onlysave('git root is ' .. git_root)
  vim.g.pwd = git_root
  vim.api.nvim_set_current_dir(git_root)
  vim.cmd('NERDTree ' .. git_root)
  vim.g.isopenednerdtree = 1
end

-- set up global variables for nerdtree plugin
vim.g.NERDTreeFileLines = 1
vim.g.NERDTreeHijackNetrw = 0
vim.g.NERDTreeChDirMode = 2
-- keymap settings

vim.api.nvim_set_keymap('n', '<C-b>', ':lua SetNERDTreeRootToNearestGit()<CR>', { noremap = true, silent = true })
-- adjust action
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
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
