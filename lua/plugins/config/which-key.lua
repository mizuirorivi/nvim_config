
local wk = require("which-key")

vim.g.mapleader = "\\"

wk.setup({
  triggers = {"<space>"}
})

require('telescope').load_extension('vim_bookmarks')

wk.register({
  f = {
    name = "find by using Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    n = { "<cmd> Telescope notify<cr>","Show Notifications"},
    ma = { "<cmd>Telescope vim_bookmarks all<cr>","Show all bookmarks"},
    mc = { "<cmd>Telescope vim_bookmarks current_file<cr>","Show bookmarks in current file"},
  },
  s = {
    name = "Terminal",
    s = { "<cmd>ToggleTerm<CR>", "Toggle Terminal" }
  },
  ["?"] = { function() require("which-key").show({}) end, "Show Keymaps (which-key)" },
},{prefix="<space>"})

vim.keymap.set('n', '<leader>k', "<cmd>lua require('fzf-lua').keymaps()<CR>", { desc = "Search Keymaps" })
