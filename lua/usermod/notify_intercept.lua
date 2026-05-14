vim.keymap.set("n", "c", function()
  local ok_noice, noice = pcall(require, "noice")
  if ok_noice then noice.cmd("dismiss") end
  local ok_notify, notify = pcall(require, "notify")
  if ok_notify then notify.dismiss({ silent = true, pending = true }) end
end, { desc = "Dismiss all notifications" })
