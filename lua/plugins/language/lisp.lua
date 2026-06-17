local on_attach = require('plugins/language/onattach').on_attach

local lisp_filetypes = { "clojure", "fennel", "lisp", "scheme", "racket", "janet", "hy" }

-- autopairs を Lisp ファイルで無効化（paredit に任せる）
vim.api.nvim_create_autocmd("FileType", {
  pattern = lisp_filetypes,
  callback = function()
    local ok, autopairs = pcall(require, "nvim-autopairs")
    if ok then
      autopairs.disable()
    end
  end,
})

-- Lisp ファイル共通設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = lisp_filetypes,
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local opts = { buffer = buf, silent = true }

    -- paredit 補助キーマップ（localleader = \）
    vim.keymap.set("n", "<localleader>w(", function()
      require("nvim-paredit").api.wrap_element_under_cursor("(", ")")
    end, vim.tbl_extend("force", opts, { desc = "Wrap with ()" }))

    vim.keymap.set("n", "<localleader>w[", function()
      require("nvim-paredit").api.wrap_element_under_cursor("[", "]")
    end, vim.tbl_extend("force", opts, { desc = "Wrap with []" }))

    vim.keymap.set("n", "<localleader>w{", function()
      require("nvim-paredit").api.wrap_element_under_cursor("{", "}")
    end, vim.tbl_extend("force", opts, { desc = "Wrap with {}" }))

    -- インデント幅は Lisp 慣習の 2 スペース
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    -- 行末スペースを目立たせない（Lisp は括弧で構造を表現）
    vim.opt_local.list = false
  end,
})

-- Clojure LSP
vim.lsp.config('clojure_lsp', {
  on_attach = on_attach,
})
vim.lsp.enable('clojure_lsp')

-- Fennel LSP
vim.lsp.config('fennel_language_server', {
  on_attach = on_attach,
  settings = {
    fennel = {
      workspace = { library = vim.api.nvim_list_runtime_paths() },
      diagnostics = { globals = { "vim" } },
    },
  },
})
vim.lsp.enable('fennel_language_server')
