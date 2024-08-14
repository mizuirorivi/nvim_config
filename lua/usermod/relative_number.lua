vim.api.nvim_create_user_command('EnableRelNumber', function()
  vim.opt.relativenumber = true
end, {})
vim.api.nvim_create_user_command('DisableRelNumber',function()
  vim.opt.relativenumber = false
end,{})

vim.opt.relativenumber = true
