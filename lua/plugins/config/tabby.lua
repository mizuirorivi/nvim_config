local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
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
vim.api.nvim_set_keymap("n", "ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "te", ":tabedit ", { noremap = true })
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "tmp", ":-tabmove<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tmn", ":+tabmove<CR>", { noremap = true })
-- move curent window to tab
vim.api.nvim_set_keymap("n", "tw", "<C-W>T", { noremap = true })
-- duplicate current window in new tab
vim.api.nvim_set_keymap("n", "td", ":lua duplicate_current_window_in_new_tab()<CR>", { noremap = true })
