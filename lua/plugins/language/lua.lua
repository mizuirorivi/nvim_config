local on_attach = require('plugins/language/onattach').on_attach

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
      keywordSnippet = "Both",
      callSnippet = "Both",
    },
    hint = {
      enable = true,
    },
  },
}

vim.lsp.config('lua_ls', {
  settings = lua_ls_settings,
  on_attach = on_attach,
})
vim.lsp.enable('lua_ls')
