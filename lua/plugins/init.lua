-- packer setup
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)

  -- file explorer
  use 'mizuirorivi/EnhancedNERDTree'
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

  -- snippets
  use "rafamadriz/friendly-snippets"
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --lsp 環境設定
  use 'prabirshrestha/vim-lsp'
  use 'mattn/vim-lsp-settings'
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
  -- notify
  use 'rcarriga/nvim-notify'
  use 'folke/noice.nvim'
  use 'MunifTanjim/nui.nvim'
  

  -- for vim debug
  use 'nvim-lua/plenary.nvim'

  -- for bookmarks
  use 'MattesGroeger/vim-bookmarks'

  -- one-small-step-for-vimkind (for lua debug)
  use 'jbyuki/one-small-step-for-vimkind'

  -- DAP client
  use 'mfussenegger/nvim-dap'

  -- Intellisense engine
  use({'neoclide/coc.nvim',run = 'yarn install && yarn build'})

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
  use 'folke/neodev.nvim'
  -- for formatter
  -- 
  --
  --  FOR LANGUAGE
  --
  

  --ruby 開発環境
  use {'vim-ruby/vim-ruby', ft = 'ruby'}
  -- lua Environment
  use 'thugcee/nvim-map-to-lua'

  -- for rust
  use 'simrat39/rust-tools.nvim'
  -- javascript  
  -- use 'yuezk/vim-js'
  -- use 'HerringtonDarkholme/yats.vim'
  -- use 'maxmellon/vim-jsx-pretty'
  -- for markdown
  --
  use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })
  use({
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup({
          openai_params = {
                -- NOTE: model can be a function returning the model name
                -- this is useful if you want to change the model on the fly
                -- using commands
                -- Example:
                -- model = function()
                --     if some_condition() then
                --         return "gpt-4-1106-preview"
                --     else
                --         return "gpt-3.5-turbo"
                --     end
                -- end,
                model = "gpt-4-1106-preview",
                frequency_penalty = 0,
                presence_penalty = 0,
                max_tokens = 4095,
                temperature = 0.2,
                top_p = 0.1,
                n = 1,
        },
                  api_key_cmd = "echo 'my_key'"

      })
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
      }
    })
end)
