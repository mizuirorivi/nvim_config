
-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

vim.opt.runtimepath:append('~/.local/share/nvim/site/pack/packer/opt/*')

return require('packer').startup(function(use)
   -- Dashboard (start screen)
  -- use {
  --   'goolord/alpha-nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  -- }
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}
  -- -- A line for the vim tab page, not for buffers
  use 'nanozuki/tabby.nvim'
  -- use {
  --   'glepnir/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --       require('dashboard').setup {
  --         -- config
  --       }
  --   end,
  --   requires = {'nvim-tree/nvim-web-devicons'}
  -- }
  use {
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          require'alpha'.setup(require'alpha.themes.startify'.config)
      end
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'eandrju/cellular-automaton.nvim' 
  use {
  "rinx/nvim-ripgrep",
  config = function()
    require("nvim-ripgrep").setup {
      prompt = "❯ ",
      window = {
        width = 0.8,
        border = "rounded",
      },
      open_qf_fn = function()
        return vim.api.nvim_command("copen")
      end, 
    }
  end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
