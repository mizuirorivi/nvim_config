"USER CONFIG by mizuiro_rivi
"set number             "行番号を表示
set autoindent         "改行時に自動でインデントする set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed,unnamedplus "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
inoremap <silent> jj <ESC>
" 行末を '$'、タブを '>...'、末尾のスペースを '_' で表示
"set listchars=eol:$,tab:>.,trail:_,space:+
set list    " 制御文字を表示
tnoremap <Esc> <C-\><C-n>  "terminal jobモードのescapeを<ESC>キーで出来るようにする
" ウィンドウ間を逆に移動
noremap  <A-k> <C-w>W 
inoremap <A-k> <Esc><C-w>W
tnoremap <A-k> <C-\><C-n><C-w>W
" 他のウィンドウを閉じて最大化する
noremap  <A-o> <C-w>o
inoremap <A-o> <Esc><C-w>o
tnoremap <A-o> <C-\><C-n><C-w>o
" コマンドラインモードに移行（これは英語キーボードの場合です）
noremap  <A-;> :
inoremap <A-;> <Esc><C-o>:
tnoremap <A-;> <C-\><C-n><C-w>:
" 検索に移行
noremap  <A-/> /
inoremap <A-/> <Esc><C-o>/
tnoremap <A-/> <C-\><C-n>/
" smart caseに移行
set ignorecase smartcase
""""""""""""""""""""""""""""""""""""""
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

