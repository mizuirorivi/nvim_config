local function is_empty_and_untitled()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local buflines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
  return bufname == "" and #buflines == 1 and buflines[1] == ""
end
vim.api.nvim_set_keymap('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- local copilot_notify = require("usermod.mynotify").new("Copilot", vim.log.levels.INFO)
-- local timer = vim.loop.new_timer()
-- local timer_flag = false
-- timer:start(0, 1000, vim.schedule_wrap(function()
--   if timer_flag then
--     timer:stop()
--     timer:close()
--     return
--   end
--   local cmds = vim.api.nvim_get_commands({})
--   for name, _ in pairs(cmds) do
--     if name:match("Copilot") then
--       if not is_empty_and_untitled() then
--         vim.cmd("Copilot enable")
--         vim.cmd("Copilot status")
--         copilot_notify:onlysave("Copilot is enabled")
--       else
--         copilot_notify:onlysave("Copitlot is not enabled for empty buffer")
--       end
--       timer_flag = true
--       if not timer:is_closing() then
--         timer:stop()
--         timer:close()
--       end
--       break
--     end
--   end
-- end))

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function()
--     if not timer:is_closing() then
--       timer:stop()
--       timer:close()
--     end
--   end
-- })
