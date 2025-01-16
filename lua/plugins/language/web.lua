-- lua/plugins/language/web.lua
  local lspconfig = require("lspconfig")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_null_ls = require("mason-null-ls")
  local null_ls = require("null-ls")

  -- あなたの on_attach を読み込み
  local on_attach = require("plugins/language/onattach").on_attach

  -- Mason のセットアップ
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = {
      "tsserver",
      "eslint",
      -- ほかに必要ならここに追加
    },
    automatic_installation = true,
  })

  mason_null_ls.setup({
    ensure_installed = { "prettier" },
    automatic_installation = true,
  })

  -- null-ls (フォーマッタ・リンターなど)
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.diagnostics.eslint_d, など必要に応じて
    },
  })

  -- lspconfig のセットアップ(tsserver, eslint)
  mason_lspconfig.setup_handlers({
    function (server_name)
      local opts = {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }
      lspconfig[server_name].setup(opts)
    end,
  })

lspconfig.tsserver.setup{
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
