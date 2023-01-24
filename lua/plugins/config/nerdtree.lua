local function init()
  vim.api.nvim_set_keymap("n", "<C-b>", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
end 

return {
  init = init
}
