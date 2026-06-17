-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  { "vim-denops/denops.vim",   lazy = false },
  { "lambdalisue/kensaku.vim", dependencies = { "vim-denops/denops.vim" } },
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },
  {
    "mizuirorivi/template.nvim",
    cmd = { 'Template', 'TemProject' },
    dependencies = { 'airblade/vim-rooter' }
  },
  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup {
        rooter_patterns = { '.root', '.git', '.hg', '.svn', 'Makefile', 'package.json', 'Cargo.toml' },
        trigger_patterns = { '*' },
        manual = false,
        fallback_to_parent = true,
      }
    end
  },
  -- Key Biding Help
  "folke/which-key.nvim",
  event = "VeryLazy",

  'mrjones2014/legendary.nvim',
  version = 'v2.13.9',
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  dependencies = { 'kkharji/sqlite.lua' },


  -- undo tree
  'mbbill/undotree',
  -- file explorer

  -- 'mizuirorivi/EnhancedNERDTree',

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        highlight = { enable = true },
      }
    end
  },
  'nvim-tree/nvim-tree.lua',

  'unkiwii/vim-nerdtree-sync',
  'echasnovski/mini.base16',

  -- for manipulate window
  { 'yorickpeterse/nvim-window', url = 'https://gitlab.com/yorickpeterse/nvim-window.git' },
  'sunjon/shade.nvim',

  -- color theme
  { 'ellisonleao/gruvbox.nvim' },
  -- color theme switcher
  { 'zaldih/themery.nvim' },
  -- visualize color code
  'norcalli/nvim-colorizer.lua',
  -- color picker
  'nvim-colortils/colortils.nvim',
  'ryanoasis/vim-devicons',
  { 'echasnovski/mini.icons', version = false },

  -- air line status bar
  'vim-airline/vim-airline',

  -- fuzzing tool
  'ibhagwan/fzf-lua',
  'mbbill/undotree',

  -- snippets
  'rafamadriz/friendly-snippets',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { {
      'nvim-lua/plenary.nvim',
      "debugloop/telescope-undo.nvim",
    } }
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').setup {
        defaults = {
          -- デフォルト設定
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
      -- FZFエクステンションをロード
      require('telescope').load_extension('fzf')
    end
  },
  -- markdown heading
  "crispgm/telescope-heading.nvim",

  'neovim/nvim-lspconfig',
  'antosha417/nvim-lsp-file-operations',
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
  },
  -- -- automatically install language server
  -- {
  --   "dundalek/lazy-lsp.nvim",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("lazy-lsp").setup {}
  --   end
  -- },

  -- comment機能  `gcc` でコメントアウト `gc` でコメント解除
  'joom/vim-commentary',

  -- notify
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = false, -- lua/plugins/noice.lua で setup する
  },

  -- 'MunifTanjim/nui.nvim',

  -- for vim debug
  'nvim-lua/plenary.nvim',

  -- for bookmarks
  'MattesGroeger/vim-bookmarks',
  'tom-anders/telescope-vim-bookmarks.nvim',

  -- one-small-step-for-vimkind (for lua debug)
  'jbyuki/one-small-step-for-vimkind',

  -- DAP client
  'mfussenegger/nvim-dap',

  -- for multi cursor
  { 'mg979/vim-visual-multi', branch = 'master' },

  -- add text object
  'wellle/targets.vim',

  'kyazdani42/nvim-web-devicons',
  -- pico 8
  'bakudankun/pico-8.vim',

  -- terminal
  { 'akinsho/toggleterm.nvim', version = "*", config = true },

  -- tab
  { "tiagovla/scope.nvim" },

  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    opts = {
      fast_wrap = {
        map = '<C-a>',                       -- 使用するキーのマッピング
        chars = { '{', '[', '(', '"', "'" }, -- 囲むのに使う文字
        pattern = [=[[%'%"%>%]%)%}%,]]=],    -- パターンマッチングの設定
        end_key = '$',                       -- 終了キー
        keys = 'qwertyuiopzxcvbnmasdfghjkl', -- キーの設定
        highlight = 'Search',                -- ハイライトの色
        highlight_grey = 'Comment'           -- グレーのハイライトの色
      },
    }
    -- this is equalent to setup({}) function
  },

  -- for formatter

  -- FOR LANGUAGE

  -- language server manager
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { "clangd", "pyright", "lua_ls", "clojure_lsp", "fennel_language_server" },
        automatic_installation = true,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  -- Lisp structural editing (paredit)
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "lisp", "scheme", "racket", "janet" },
    config = function()
      require("nvim-paredit").setup({
        use_default_keys = true,
        cursor_behaviour = "follow",
        indent = { enabled = true, default_amount = 2 },
        extension = {},
      })
    end,
  },

  -- Rainbow parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Conjure: REPL integration for Lisp family
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "lisp", "scheme", "racket", "janet", "hy" },
    config = function()
      vim.g["conjure#log#hud#width"] = 1.0
      vim.g["conjure#log#hud#height"] = 0.4
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#mapping#prefix"] = "\\"
    end,
  },

  -- ruby 開発環境
  { 'vim-ruby/vim-ruby',    ft = 'ruby' },

  -- lua environment
  'thugcee/nvim-map-to-lua',

  -- for rust
  'simrat39/rust-tools.nvim',

  -- javascript
  -- 'yuezk/vim-js',
  -- 'herringtondarkholme/yats.vim',
  -- 'maxmellon/vim-jsx-pretty',

  -- for markdown
  'ixru/nvim-markdown',
  {
    "mizuirorivi/peek.nvim",
    ft = "markdown",
    build = "deno task --quiet build:fast",
    config = function()
      local peek = require("peek")
      local uv = vim.uv or vim.loop
      local sysname = uv.os_uname().sysname

      local app

      if sysname == "Linux" then
        app = { "/usr/bin/google-chrome", "--new-window" }
      elseif sysname == "Darwin" then
        app = "webview"
      elseif sysname == "Windows_NT" then
        -- Windows
        app = "webview"
      else
        app = "webview"
      end

      peek.setup({
        app = app,
        filetype = { "markdown" },
        tab = true,
        useful_web = true,
      })

      vim.api.nvim_create_user_command("PeekOpen", function()
        peek.open()
      end, { desc = "Open Markdown Preview Window" })

      vim.api.nvim_create_user_command("PeekClose", function()
        peek.close()
      end, { desc = "Close Markdown Preview Window" })

      vim.api.nvim_create_user_command('PeekUsefulON', function()
        require('peek').set_useful_web(true)
      end, { desc = "Open Markdown Preview Window with Useful" })
      vim.api.nvim_create_user_command('PeekUsefulOFF', function()
        require('peek').set_useful_web(false)
      end, { desc = "Turn Off Useful on Markdown Preview Window" })
      vim.api.nvim_create_user_command('PeekUsefulToggle', function()
        require('peek').toggle_useful_web()
      end, { desc = "Switch Feature of Useful on Markdown Preview Window" })
    end,
  },
  -- for completion AI
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
  },
  -- "Exafunction/codeium.vim",
  {
    "jackMort/ChatGPT.nvim",
    lazy = true,
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ChatGPTRun" },
    config = function()
      require("chatgpt").setup({
        openai_params = {
          model = "gpt-4o-1106-preview",
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
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {                                        -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
      plugins = {
        non_standalone = true,
      }
    },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "yetone/avante.nvim",
    lazy = true,
    cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle", "AvanteFocus", "AvanteRefresh", "AvanteSwitchProvider", "AvanteEdit" },
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,  -- timeout in milliseconds
        temperature = 0,  -- adjust if needed
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    }
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = { "lambdalisue/vim-kensaku" },
    config = function() require("plugins.flash") end,
  },
})
