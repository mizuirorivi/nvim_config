vim.cmd [[
set noautochdir
set number
set autoindent
set shiftwidth=2
set expandtab
set splitright
set clipboard=unnamed,unnamedplus
set hls
inoremap <silent> jj <ESC>
set list
" show tab as "  "
set listchars=tab:\ \ ,eol:$
tnoremap <Esc> <C-\><C-n>
noremap  <A-k> <C-w>W
inoremap <A-k> <Esc><C-w>W
tnoremap <A-k> <C-\><C-n><C-w>W
noremap  <A-o> <C-w>o
inoremap <A-o> <Esc><C-w>o
tnoremap <A-o> <C-\><C-n><C-w>o
noremap  <A-;> :
inoremap <A-;> <Esc><C-o>:
tnoremap <A-;> <C-\><C-n><C-w>:
noremap  <A-/> /
inoremap <A-/> <Esc><C-o>/
tnoremap <A-/> <C-\><C-n>/
set ignorecase smartcase
]]
-- Avoid Alt-key (ESC+key) mappings like <A-k> being split by the ESC timeout.
vim.opt.ttimeoutlen = 10
vim.api.nvim_set_keymap('n', '<C-s>', ':saveas ', { noremap = true })
vim.keymap.set('x', '<A-/>', '/\\%V', { noremap = true, desc = "Search within visual selection" })
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- Show macro recording indicator in the airline statusline.
-- airline#init#sections() only defines section_a if it isn't already set, so we
-- rebuild it via airline#section#create in the AirlineAfterInit hook (the
-- documented extension point) to inject the recording register alongside mode.
vim.cmd([[
  function! AirlineRecordingInit()
    call airline#parts#define_raw('recording',
      \ '%#__accent_bold#%{reg_recording()!=""?" REC@".reg_recording()." ":""}%#__restore__#')
    let g:airline_section_a = airline#section#create_left(
      \ ['mode', 'recording', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert', 'executable'])
  endfunction
  augroup AirlineRecordingIndicator
    autocmd!
    autocmd User AirlineAfterInit call AirlineRecordingInit()
  augroup END
]])

-- %{reg_recording()} is only re-evaluated when the statusline redraws, which does
-- not happen automatically when recording starts/stops. Force a redraw on both.
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function()
    -- On RecordingLeave reg_recording() is still set, so defer the redraw.
    vim.schedule(function()
      vim.cmd("redrawstatus")
    end)
  end,
})

vim.g["denops#deno"] = vim.fn.expand("$HOME/.deno/bin/deno")
vim.g.rooter_manual_only = 1
local M = {}
return M
