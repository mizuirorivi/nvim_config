local Plug = require 'usermod.vimplug'
Plug.begin('~/.local/share/nvim/plugged/')
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

-- air line status bar
Plug 'vim-airline/vim-airline'

-- dashboard-nvim(https://github.com/applejwjcat/dashboard-nvim)
Plug 'glepnir/dashboard-nvim'

-- fuzzing tool(https://github.com/junegunn/fzf.vim)
Plug('ibhagwan/fzf-lua', {
  branch='main'
})
vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

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

Plug.ends()
