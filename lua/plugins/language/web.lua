-- lua/plugins/language/web.lua
  local ok_mason, mason = pcall(require, "mason")
  local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  local ok_mason_null, mason_null_ls = pcall(require, "mason-null-ls")
  local ok_null, null_ls = pcall(require, "null-ls")

  if not (ok_mason and ok_mason_lsp) then return end

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

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = {
      "ts_ls",
      "eslint",
    },
    automatic_installation = true,
  })

  if ok_mason_null then
    mason_null_ls.setup({
      ensure_installed = { "prettier" },
      automatic_installation = true,
    })
  end

  if ok_null then
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })
  end
