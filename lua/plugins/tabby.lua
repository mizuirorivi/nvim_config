
local tabbylog = require("usermod.mynotify").new("tabbylog", vim.log.levels.INFO)
_G.duplicate_current_window_in_new_tab = function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd('tabnew')
  vim.api.nvim_set_current_buf(current_buf)
end
local wk = require("which-key")

function _G.tabcreate()
  vim.cmd('tabnew')
  -- vim.g.pwd is from nerdtree.lua in plugins/nertree.lua.
  -- why bother changing current directory by vim.g.pwd from nertree.lua, because tabby change current directory to wrong one when new tab is opend
  if vim.g.pwd == nil then
    tabbylog:onlysave('vim.g.pwd is nil and cwd is ' .. vim.fn.getcwd())
    vim.g.pwd = vim.fn.getcwd()
  else 
    tabbylog:onlysave('vim.g.pwd is ' .. vim.g.pwd)
  end
  
  vim.api.nvim_set_current_dir(vim.g.pwd)
end

-- Register key mappings with which-key
wk.register({
  t = {
    name = "Tabs/Windows",
    a = { ":lua _G.tabcreate()<CR>", "New Tab" },
    e = { ":tabedit ", "Edit Tab" },
    c = { ":tabclose<Cju>", "Close Tab" },
    n = { ":tabn<CR>", "Next Tab" },
    p = { ":tabp<CR>", "Previous Tab" },
    m = {
      name = "Move Tab",
      p = { ":-tabmove<CR>", "Move Tab to Previous Position" },
      n = { ":+tabmove<CR>", "Move Tab to Next Position" },
    },
    w = { "<C-W>T", "Move Current Window to New Tab" },
    d = { ":lua duplicate_current_window_in_new_tab()<CR>", "Duplicate Current Window in New Tab" },
    l = {
      function()
        require('usermod.tab_switcher').switch_tab()
      end,
      "Switch Tab"
    }
  }
}, { prefix = "<space>" })

vim.api.nvim_set_keymap("n", "<leader>ta", ":lua _G.tabcreate()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>te", ":tabedit ", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
-- move current window to tab
vim.api.nvim_set_keymap("n", "<leader>tw", "<C-W>T", { noremap = true })
-- duplicate current window in new tab
vim.api.nvim_set_keymap("n", "<leader>td", ":lua duplicate_current_window_in_new_tab()<CR>", { noremap = true })


vim.api.nvim_set_keymap("n", "ta", ":lua _G.tabcreate()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "te", ":tabedit ", { noremap = true })
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tl", ':lua require("usermod.tab_switcher").switch_tab()<CR>', { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "tmp", ":-tabmove<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tmn", ":+tabmove<CR>", { noremap = true })
-- move current window to tab
vim.api.nvim_set_keymap("n", "tw", "<C-W>T", { noremap = true })
-- duplicate current window in new tab
vim.api.nvim_set_keymap("n", "td", ":lua duplicate_current_window_in_new_tab()<CR>", { noremap = true })
