```
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
"
```