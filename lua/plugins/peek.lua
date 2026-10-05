local wk = require("which-key")
wk.setup({
  triggers = { "<space>" }
})
wk.register({
  p = {
    name = "markdown preview",
    o = {
      "<cmd>PeekOpen<cr>", "Open Peek"
    },

    c = {
      "<cmd>PeekClose<cr>", "Close Peek"
    },
  },
}, { prefix = "<space>" })
