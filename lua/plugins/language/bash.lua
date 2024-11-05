local lspconfig = require'lspconfig'

local on_attach = require('plugins/language/onattach').on_attach
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh","zsh","bash",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    
    vim.opt_local.makeprg = "shellcheck -f gcc %"
    vim.opt_local.errorformat = "%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l:%c: %tote: %m"
  end
})
--linter
vim.g.ale_linters = {
  sh = {'shellcheck'},
}
lspconfig.bashls.setup({
  filetypes = { "sh", "bash", "zsh" },
  cmd = { "bash-language-server", "start" },
  on_attach = on_attach,
})
