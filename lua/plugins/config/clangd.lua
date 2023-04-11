vim.cmd[[
  let g:LanguageClient_serverCommands = {
  \ 'efm': ['efm-langserver', '-logfile', '/tmp/efm.log', '-loglevel', '5'],
  \ 'cpp': ['clangd'],
  \ }
]]

vim.cmd[[
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
]]
