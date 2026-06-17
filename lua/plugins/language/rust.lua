local on_attach = require('plugins/language/onattach').on_attach

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
    assist = {
      importMergeBehavior = "last",
      importPrefix = "by_self",
    },
    diagnostics = {
      enable = true,
      experimental = {
        enable = true,
      },
    },
  },
}

vim.lsp.config('rust_analyzer', {
  settings = rust_analyzer_settings,
  on_attach = on_attach,
})
