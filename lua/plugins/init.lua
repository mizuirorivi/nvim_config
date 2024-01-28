
-- packer setup
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)

  -- file explorer
  use 'scrooloose/nerdtree'
  use 'unkiwii/vim-nerdtree-sync'
  use 'echasnovski/mini.base16'
  -- for manipulate window
  use 'https://gitlab.com/yorickpeterse/nvim-window.git' -- Shade is a Neovim plugin that dims your inactive windows
  use 'sunjon/shade.nvim'

  -- color theme
  use { "ellisonleao/gruvbox.nvim" }
  use 'ryanoasis/vim-devicons'

  -- air line status bar
  use 'vim-airline/vim-airline'

  -- fuzzing tool
  use 'ibhagwan/fzf-lua'
  use 'mbbill/undotree'

  --ruby 開発環境
  use {'vim-ruby/vim-ruby', ft = 'ruby'}

  --lsp 環境設定
  use 'prabirshrestha/async.vim'
  use 'prabirshrestha/asyncomplete.vim'
  use 'prabirshrestha/asyncomplete-lsp.vim'
  use 'antosha417/nvim-lsp-file-operations'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- comment機能  `gcc` でコメントアウト `gc` でコメント解除
  use 'joom/vim-commentary'
  use 'rcarriga/nvim-notify'

  -- lua Environment
  use 'thugcee/nvim-map-to-lua'
  use 'neovim/nvim-lspconfig'

  -- for rust
  use 'simrat39/rust-tools.nvim'

  -- for vim debug
  use 'nvim-lua/plenary.nvim'

  -- for bookmarks
  use 'MattesGroeger/vim-bookmarks'

  -- one-small-step-for-vimkind (for lua debug)
  use 'jbyuki/one-small-step-for-vimkind'

  -- DAP client
  use 'mfussenegger/nvim-dap'

  -- Intellisense engine
  use 'neoclide/coc.nvim'

  -- for multi cursor
  use {'mg979/vim-visual-multi', branch = 'master'}

  -- add text object
  use 'wellle/targets.vim'

  -- firenvim
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  use 'nvim-tree/nvim-web-devicons'

  -- pico 8
  use 'bakudankun/pico-8.vim'

  -- terminal
  use {'akinsho/toggleterm.nvim', tag = '*'}
  -- taby
  use 'nanozuki/tabby.nvim'
  -- surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })
  use 'windwp/nvim-autopairs'
  use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })
end)
