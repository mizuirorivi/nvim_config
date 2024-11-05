local lspconfig = require 'lspconfig'

local on_attach = require('plugins/language/onattach').on_attach
lspconfig.clangd.setup({
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
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  on_attach = on_attach,
})
