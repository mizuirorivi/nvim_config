require("telescope").load_extension('find_template')
local wk = require("which-key")
wk.setup({
  triggers = { "<space>" }
})
wk.register({
  f = {
    name = "find Something",
    c = { "<cmd>Telescope commands<cr>", "find command and execute" },

    t = {
      "<cmd>Telescope find_template type=insert filter_ft=false<cr>", "Insert Any Template"
    },
    u = {
      "<cmd>UndotreeToggle<cr>","Show  undo history"
    }
  },
}, { prefix = "<space>" })
