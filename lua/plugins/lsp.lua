local nvim = vim.api

-- キーマッピングの設定
local opts = { silent = true, noremap = true }
-- LSP診断のカラー設定
vim.cmd[[ 
hi LspDiagnosticsDefaultWarning guifg=#87cefa
]]
