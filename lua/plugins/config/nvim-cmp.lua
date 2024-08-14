local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Luasnipを使用してスニペットを展開
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 選択されたエントリを確認
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- ここでnvim_lspソースを追加
    { name = 'luasnip' },   -- Luasnip用のソース
  }, {
    { name = 'buffer' },    -- バッファの内容を補完
  })
})
