
local M = {}

M.on_attach = function(client, bufnr)
    -- キーマッピングの設定
    local opts = { silent = true, noremap = true }
    local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap

    nvim_buf_set_keymap(bufnr, "n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

    -- which-key への登録
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
            e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Line Diagnostics" },
            q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set Loclist" },
            f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Document" },
        },
    }, { prefix = "<space>" })
end

return M
