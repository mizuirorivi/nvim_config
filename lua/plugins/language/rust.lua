local lspconfig = require('lspconfig')

-- 汎用的な on_attach 関数をインポート
local on_attach = require('plugins/language/onattach').on_attach

-- Register rustfmt as a formatter
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.rustfmt,  -- This will now use the system-installed rustfmt
    },
})

-- Define settings for rust-analyzer
local rust_analyzer_settings = {
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true,
        },
        procMacro = {
            enable = true,
        },
        checkOnSave = {
            command = "clippy",
        },
    },
}

-- Setup Rust language server with these settings and on_attach
lspconfig.rust_analyzer.setup({
    settings = rust_analyzer_settings,
    on_attach = on_attach,
})
