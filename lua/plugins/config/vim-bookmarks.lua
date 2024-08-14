vim.cmd[[
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1

nmap <Leader>fb <Plug>BookmarkToggle
nmap <Leader>fbi <Plug>BookmarkAnnotate
nmap <Leader>fba <Plug>BookmarkShowAll
nmap <Leader>fbj <Plug>BookmarkNext
nmap <Leader>fbk <Plug>BookmarkPrev
nmap <Leader>fbc <Plug>BookmarkClear
nmap <Leader>fbx <Plug>BookmarkClearAll
nmap <Leader>fbkk <Plug>BookmarkMoveUp
nmap <Leader>fbjj <Plug>BookmarkMoveDown
nmap <Leader>fbg <Plug>BookmarkMoveToLine
]]
