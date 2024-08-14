local lspconfig = require'lspconfig'

lspconfig.clangd.setup({
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "cc" },  -- 対象とするファイルタイプ
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    on_attach = function(client, bufnr)
        -- キーマッピングの設定
        local opts = { silent = true, noremap = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

        local wk = require("which-key")
        
        wk.register({
          g = {
            name = "LSP",
            d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
            r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find References" },
            h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation" },
            i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
            t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" },
            n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
            a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            e = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show Line Diagnostics" },
            q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Set Loclist" },
            f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Document" },
          },
        }, { prefix = "<space>" })
    end,
})
