local nvim = vim.api
nvim.nvim_set_keymap("n","<Leader>gd",":LspDefinition",{silent=true})
nvim.nvim_set_keymap("n","<Leader>gr",":LspReferences",{silent=true})
vim.cmd[[ 
hi LspDiagnosticsDefaultWarning guifg=#87cefa
]]
-- local nvim_lsp = require('lspconfig')

-- nvim_lsp.pyright.setup{
--     settings = {
--         python = {
--             pythonPath = "/home/r3v321se/.pyenv/versions/3.9.18/bin/python"
--         }
--     }
-- }

