
local theme = {
  fill = 'TabLineFill',
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

require('tabby.tabline').set(function(line)
  return {
    {
      { '  ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
    end),
    {
      line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
    },
    hl = theme.fill,
  }
end)

_G.duplicate_current_window_in_new_tab = function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd('tabnew')
  vim.api.nvim_set_current_buf(current_buf)
end

local wk = require("which-key")

-- Register key mappings with which-key
wk.register({
  t = {
    name = "Tabs/Windows",
    a = { ":$tabnew<CR>", "New Tab" },
    e = { ":tabedit ", "Edit Tab" },
    c = { ":tabclose<CR>", "Close Tab" },
    n = { ":tabn<CR>", "Next Tab" },
    p = { ":tabp<CR>", "Previous Tab" },
    m = {
      name = "Move Tab",
      p = { ":-tabmove<CR>", "Move Tab to Previous Position" },
      n = { ":+tabmove<CR>", "Move Tab to Next Position" },
    },
    w = { "<C-W>T", "Move Current Window to New Tab" },
    d = { ":lua duplicate_current_window_in_new_tab()<CR>", "Duplicate Current Window in New Tab" },
  }
}, { prefix = "<space>" })

vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
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
