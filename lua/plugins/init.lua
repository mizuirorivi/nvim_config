local Plug = require 'usermod.vimplug'
Plug.begin('~/.config/nvim/plugged/')
-- ファイルツリー表示
Plug 'scrooloose/nerdtree'

Plug 'unkiwii/vim-nerdtree-sync'

-- Plug 'beauwilliams/focus.nvim'
-- for maniuplate window
Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'
-- -- Shade is a Neovim plugin that dims your inactive windows
Plug 'sunjon/shade.nvim'
-- color theme
Plug('folke/tokyonight.nvim', { 
  branch='main'
})
Plug 'ryanoasis/vim-devicons'
-- air line status bar
Plug 'vim-airline/vim-airline'
-- fuzzing tool(https://github.com/junegunn/fzf.vim)
Plug('ibhagwan/fzf-lua')

--ruby 開発環境
Plug('vim-ruby/vim-ruby', {
  ft='ruby'
})
-- --ruby 開発環境
-- Plug('vim-ruby/vim-ruby', {
--   ft='ruby'
-- })

--lsp 環境設定
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'ajh17/vimcompletesme'
Plug 'Shougo/ddc.vim'
Plug 'shun/ddc-vim-lsp'

-- comment機能  `gcc` でコメントアウト `gc` でコメント解除
Plug 'joom/vim-commentary'

Plug 'rcarriga/nvim-notify'

-- lua 環境
Plug 'thugcee/nvim-map-to-lua'
Plug 'neovim/nvim-lspconfig'
-- for rust
Plug 'simrat39/rust-tools.nvim'
-- for vim debug
Plug 'nvim-lua/plenary.nvim'

--  one-small-step-for-vimkind (for lua debug)
Plug 'jbyuki/one-small-step-for-vimkind'

-- You will also need a comptabile DAP client

Plug 'mfussenegger/nvim-dap'

-- for multi cursole (https://github.com/mg979/vim-visual-multi)
Plug('mg979/vim-visual-multi', {
  branch='master'
})

Plug('glacambre/firenvim', { 
  run=function(plugin_name)
    vim.fn['firenvim#install'](0)
  end
})
-- pico 8
Plug 'bakudankun/pico-8.vim'

-- terminal
Plug 'akinsho/toggleterm.nvim'
Plug.ends()
