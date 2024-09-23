local M = {}
function M.my_notify(message, vlevel)
  local status, notify = pcall(require, 'notify')
  if status then
    notify.setup({
      minimum_width = 20,
      background_colour = "#000000",
      render = "wrapped-compact",
    })
    option = {
      title = "Neovim CONFIG INFORMATION",
      level = vlevel,
      timeout =  0.05
    }
    notify.Option = option
    notify.notify(message,"info", option)
  else
    vim.notify(message, vim.log.levels.TRACE)
  end
end

return M
