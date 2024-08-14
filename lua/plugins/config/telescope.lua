require("telescope").load_extension('find_template')
local wk = require("which-key")
wk.setup({
  triggers = { "<space>" }
})
wk.register({
  f = {
    name = "find by using Telescope",
    c = { "<cmd>Telescope commands<cr>", "find command and execute" },

    t = {
      "<cmd>Telescope find_template type=insert filter_ft=false<cr>", "Insert Any Template"
    }
  },
}, { prefix = "<space>" })
