
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged/')
-- ファイルツリー表示
Plug 'scrooloose/nerdtree'
-- Start NERDTree and leave the cursor in it.
vim.cmd[[autocmd VimEnter * NERDTree]]
-- Open the existing NERDTree on each new tab.
vim.cmd[[autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif]]
vim.cmd[[map <C-b> :NERDTreeToggle<CR>]]

--vim.cmd[[
--  NERDTreeWinSize=32
--  NERDTreeWinPos=--left--
--  NERDTreeShowHidden=1
--  NERDTreeAutoDeleteBuffer=1
--  NERDTreeAutoDeleteBuffer=1
--]]

-- air line status bar
Plug 'vim-airline/vim-airline'
--ruby 開発環境
--Plug 'vim-ruby/vim-ruby', {'for':'ruby'}

vim.call('plug#end')
