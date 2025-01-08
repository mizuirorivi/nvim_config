local lspconfig = require('lspconfig')

-- 汎用的な on_attach 関数をインポート
local on_attach = require('plugins/language/onattach').on_attach

-- Define settings for Lua language server
local lua_ls_settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      globals = { 'vim' },
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
    completion = {
      enable = true,
      -- キーワードのスニペットを有効化（"Both"でキーワード補完とスニペット両方）
      keywordSnippet = "Both",
      -- 呼び出しスニペットを有効化（"Both"で関数呼び出し補完とスニペット両方）
      callSnippet = "Both",
      -- 必要に応じて、ワークスペースワード補完や表示方法を調整可能
      -- workspaceWord = true,
      -- showWord = "Disable",
    },
    hint = {
      -- ヒントを有効にすることで型推論などの補助情報が表示される場合があります
      enable = true,
    },
  },
}

-- Setup Lua language server with these settings and on_attach
lspconfig.lua_ls.setup({
  settings = lua_ls_settings,
  on_attach = on_attach,
})
