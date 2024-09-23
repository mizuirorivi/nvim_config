vim.api.nvim_set_keymap('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

local my_notify = require("usermod.mynotify").my_notify
local timer = vim.loop.new_timer()
local timer_flag = false
timer:start(0, 1000, vim.schedule_wrap(function()
  if timer_flag then
    timer:stop()
    timer:close()
    return
  end
  local cmds = vim.api.nvim_get_commands({})
  for name, _ in pairs(cmds) do
    if name:match("Copilot") then
      vim.cmd("Copilot enable")
      vim.cmd("Copilot status")
      my_notify("Copilot is enabled", vim.log.levels.INFO)
      timer_flag = true
      timer:stop()
      timer:close()
      break 
    end
  end
end))

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if not timer:is_closing() then
      timer:stop()
      timer:close()
    end
  end
})
