local on_attach = require('plugins/language/onattach').on_attach

vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm"
  },
  filetypes = { "c", "cpp", "cc" },
  root_dir = function(fname)
    return vim.fs.root(fname, { "compile_commands.json", "compile_flags.txt", ".git" })
  end,
  on_attach = on_attach,
})
vim.lsp.enable('clangd')
