"""""""""""""""""""""""""""""""""""""
"vim plug script----------------------

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
" navigatorツール
Plug 'easymotion/vim-easymotion'

" ファイルツリー表示
Plug 'scrooloose/nerdtree'
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
map <C-b> :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeAutoDeleteBuffer=1

" air line status bar
Plug 'vim-airline/vim-airline'
"ruby 開発環境
Plug 'vim-ruby/vim-ruby', {'for':'ruby'}




" List ends here. Plugins become visible to Vim after this call.
call plug#end()
map <Leader> <Plug>(easymotion-prefix)

