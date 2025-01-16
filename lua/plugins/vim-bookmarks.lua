local wk = require("which-key")
require('telescope').load_extension('vim_bookmarks')


vim.cmd [[
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1

nmap <Leader>mb <Plug>BookmarkToggle
nmap <Leader>mi <Plug>BookmarkAnnotate
nmap <Leader>ma <Plug>BookmarkShowAll
nmap <Leader>mj <Plug>BookmarkNext
nmap <Leader>mk <Plug>BookmarkPrev
nmap <Leader>mc <Plug>BookmarkClear
nmap <Leader>mx <Plug>BookmarkClearAll
nmap <Leader>mg <Plug>BookmarkMoveToLine

let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
]]
wk.setup({
  triggers = { "<space>" }
})
wk.register({
  m = {
    name = "bookmark",
    a = { "<cmd>Telescope vim_bookmarks all<cr>", "Show all bookmarks" },
    b = { "<Plug>BookmarkToggle", "Bookmark create" },
    i = { "<Plug>BookmarkAnnotate", "Bookmark annotate" },
    j = { "<Plug>BookmarkNext", "Bookmark next" },
    k = { "<Plug>BookmarkPrev", "Bookmark prev" },
    f = { "<cmd>Telescope vim_bookmarks current_file<cr>", "Show bookmarks in current [f]ile" },
    c = { "<Plug>BookmarkClear", "Bookmark clear" },
    x = { "<Plug>BookmarkClearAll", "Bookmark clear all" },
    g = { "<Plug>BookmarkMoveToLine", "Bookmark move to line"
    }
  }
})
