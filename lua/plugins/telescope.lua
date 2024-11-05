require('telescope').setup({
  defaults = {
    -- other options...
    log_level = vim.log.levels.DEBUG
  }
})
require("telescope").load_extension('find_template')
local builtin = require('telescope.builtin')
local wk = require("which-key")

wk.setup({
  triggers = { "<space>" },

  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown()
    }
  }
})
wk.register({
  f = {
    name = "find Something",
    c = { "<cmd>Telescope commands<cr>", "find command and execute" },

    t = {
      function()
        vim.cmd("Telescope find_template type=insert filter_ft=false")
        _G.template_persistent_vars = {}
      end,
      "find template and insert"
    },
    u = {
      "<cmd>UndotreeToggle<cr>","Show  undo history"
    },
    j = {
     "<cmd>Telescope jumplist<CR>", "Show jumplist" 
    }
  },
}, { prefix = "<space>" })

