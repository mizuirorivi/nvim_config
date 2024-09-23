local lspconfig = require('lspconfig')

-- 汎用的な on_attach 関数をインポート
local on_attach = require('plugins/language/onattach').on_attach

-- Define settings for python
local pyright_settings = {
    python = {
        analysis = {
            typeCheckingMode = "basic",  -- Options: "off", "basic", "strict"
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",  -- "openFilesOnly" or "workspace"
        },
    },
}
local null_ls = require("null-ls")
-- Register black as a formatter
null_ls.register(null_ls.builtins.formatting.black.with({
    extra_args = { "--fast" },
}))
-- Setup Lua language server with these settings and on_attach
lspconfig.pyright.setup({

    settings = pyright_settings,
    on_attach = on_attach,
})

