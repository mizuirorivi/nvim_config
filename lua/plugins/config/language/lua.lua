
local lspconfig = require('lspconfig')

-- 汎用的な on_attach 関数をインポート
local on_attach = require('plugins/config/language/onattach').on_attach

-- Define settings for Lua language server
local lua_ls_settings = {
    Lua = {
        runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
        },
        diagnostics = {
            globals = {'vim'},
        },
        workspace = {
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.stdpath('config') .. '/lua'] = true,
            },
        },
        telemetry = {
            enable = false,
        },
    },
}

-- Setup Lua language server with these settings and on_attach
lspconfig.lua_ls.setup({
    settings = lua_ls_settings,
    on_attach = on_attach,
})

