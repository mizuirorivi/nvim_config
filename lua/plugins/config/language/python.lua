local lspconfig = require('lspconfig')

-- 汎用的な on_attach 関数をインポート
local on_attach = require('plugins/config/language/onattach').on_attach

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
-- Setup Lua language server with these settings and on_attach
lspconfig.pyright.setup({

    settings = pyright_settings,
    on_attach = on_attach,
})

