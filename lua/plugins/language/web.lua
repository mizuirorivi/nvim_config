-- lua/plugins/language/web.lua
  local ok_lsp, lspconfig = pcall(require, "lspconfig")
  local ok_mason, mason = pcall(require, "mason")
  local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  local ok_mason_null, mason_null_ls = pcall(require, "mason-null-ls")
  local ok_null, null_ls = pcall(require, "null-ls")

  if not (ok_lsp and ok_mason and ok_mason_lsp) then return end

  -- あなたの on_attach を読み込み
  local on_attach = require("plugins/language/onattach").on_attach

  -- Mason のセットアップ
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = {
      "ts_ls",
      "eslint",
    },
    automatic_installation = true,
    handlers = {
      function(server_name)
        local opts = {
          on_attach = on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }
        lspconfig[server_name].setup(opts)
      end,
    },
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

lspconfig.ts_ls.setup{
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
