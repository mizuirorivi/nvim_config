local Plug = require 'usermod.vimplug'
Plug.begin('~/.local/share/nvim/plugged/')
-- ファイルツリー表示
Plug 'scrooloose/nerdtree'
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

-- dashboard-nvim(https://github.com/applejwjcat/dashboard-nvim)
Plug 'glepnir/dashboard-nvim'

-- fuzzing tool(https://github.com/junegunn/fzf.vim)
Plug('ibhagwan/fzf-lua', {
  branch='main'
})

--ruby 開発環境
Plug('vim-ruby/vim-ruby', {
  ft='ruby'
})

Plug.ends()
