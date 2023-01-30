local Plug = require 'usermod.vimplug'
Plug.begin('~/.config/nvim/plugged/')
-- ファイルツリー表示
Plug 'scrooloose/nerdtree'
vim.cmd[[map <C-b> :NERDTreeToggle<CR>]]
Plug 'unkiwii/vim-nerdtree-sync'
--vim.cmd[[
--  NERDTreeWinSize=32
--  NERDTreeWinPos=--left--
--  NERDTreeShowHidden=1
--  NERDTreeAutoDeleteBuffer=1
--  NERDTreeAutoDeleteBuffer=1
--]]

Plug 'tanvirtin/monokai.nvim'

-- air line status bar
Plug 'vim-airline/vim-airline'
-- dashboard-nvim(https://github.com/applejwjcat/dashboard-nvim) Plug 'glepnir/dashboard-nvim'
-- fuzzing tool(https://github.com/junegunn/fzf.vim)
Plug('ibhagwan/fzf-lua', {
  branch='main'
})
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf'
--ruby 開発環境
Plug('vim-ruby/vim-ruby', {
  ft='ruby'
})

--lsp 環境設定
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'Shougo/ddc.vim'
Plug 'shun/ddc-vim-lsp'

-- comment機能  `gcc` でコメントアウト `gc` でコメント解除
Plug 'joom/vim-commentary'

Plug 'rcarriga/nvim-notify'

--  vim quickui
-- Plug('skywind3000/vim-quickui',{
--   config = require('plugins.config.vim-quickui')
-- })

-- lua 環境
Plug 'thugcee/nvim-map-to-lua'

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

--  one-small-step-for-vimkind (for lua debug)
Plug 'jbyuki/one-small-step-for-vimkind'

-- You will also need a comptabile DAP client

Plug 'mfussenegger/nvim-dap'

-- for markdown 
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
-- for multi cursole (https://github.com/mg979/vim-visual-multi)
Plug('mg979/vim-visual-multi', {
  branch='master'
})

Plug.ends()



-- fzf config
vim.cmd[[
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <c-F> <cmd>lua require('fzf-lua').grep()<CR>
]]
-- nvim-dap config
local dap = require"dap"
dap.configurations.lua = { 
  { 
    type = 'nlua', 
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

vim.api.nvim_set_keymap('n', '<F8>', [[:lua require"dap".toggle_breakpoint()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F9>', [[:lua require"dap".continue()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F10>', [[:lua require"dap".step_over()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<S-F10>', [[:lua require"dap".step_into()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true })

-- markdown preview config
vim.cmd[[
nmap <silent> <C-m> <Plug>MarkdownPreview
]]

-- for OS X config
-- let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
-- " or
-- let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
--
--
