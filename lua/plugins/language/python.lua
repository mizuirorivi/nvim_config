local on_attach = require('plugins/language/onattach').on_attach

local pyright_settings = {
    python = {
        analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
        },
    },
}

local ok_null, null_ls = pcall(require, "null-ls")
if ok_null then
  null_ls.register(null_ls.builtins.formatting.black.with({
      extra_args = { "--fast" },
  }))
end

vim.lsp.config('pyright', {
    settings = pyright_settings,
    on_attach = on_attach,
})
vim.lsp.enable('pyright')
