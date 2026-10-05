-- Lightweight profile: editing-focused minimal plugin set.
--
-- Loaded only when `usermod.profile` resolves to "light".
-- Goal: low RAM / fast startup on small machines (e.g. 8 GB), while keeping
-- the everyday editing workflow. Excluded on purpose:
--   LSP / mason, nvim-treesitter, telescope, nvim-cmp,
--   AI plugins (Copilot / ChatGPT / Avante), denops, peek, debuggers.
--
-- The plugin configurations that are self-contained are reused from lua/plugins
-- (fzf, nvim-tree, undotree) so the light profile behaves like the full one.

-- Disable netrw explicitly (nvim-tree replaces it). plugins/nvim-tree.lua also
-- sets these, but keeping them here makes the light profile independent of
-- plugin/config load order.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim (shared install location and helper with the full profile).
require("usermod.lazy_bootstrap").ensure()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  -- Colorscheme + theme switcher (lua/colorscheme.lua depends on both).
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
  { "zaldih/themery.nvim",      lazy = false },

  -- File explorer (nvim-web-devicons is pulled in as a dependency).
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugins.nvim-tree") end,
  },

  -- Fuzzy finder: reuse the full profile's keymaps and staging behaviour.
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function() require("plugins.fzf") end,
  },

  -- Editing helpers.
  {
    "windwp/nvim-autopairs",
    lazy = false,
    opts = {
      fast_wrap = {
        map = '<C-a>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    },
  },
  { "kylechui/nvim-surround", version = "*", lazy = false, config = true },
  {
    "mbbill/undotree",
    lazy = false,
    config = function() require("plugins.undotree") end,
  },

  -- Status line.
  { "vim-airline/vim-airline", lazy = false },
}, {
  -- Separate lockfile so switching profiles never rewrites the full lockfile.
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock-light.json",
})
