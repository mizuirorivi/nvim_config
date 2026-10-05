-- lua/plugins/language/web.lua
  local ok_null, null_ls = pcall(require, "null-ls")

  local on_attach = require("plugins/language/onattach").on_attach

  -- Global defaults for all LSP servers
  vim.lsp.config('*', {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    on_attach = on_attach,
  })

  -- ts_ls specific config
  vim.lsp.config('ts_ls', {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = function(fname)
      return vim.fs.root(fname, { "package.json", "tsconfig.json", "jsconfig.json", ".git" })
    end,
  })

  if ok_null then
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })
  end
