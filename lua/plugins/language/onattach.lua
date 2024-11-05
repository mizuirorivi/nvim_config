
local M = {}

local lsp_notify = require("usermod.mynotify").new("LSP Information", vim.log.levels.INFO)
function custom_rename()
  local current_name = vim.fn.expand("<cword>")
  local new_name = vim.fn.input("Rename " .. current_name .. " to: ")
  if not new_name or #new_name == 0 then
    return
  end
  vim.lsp.buf.rename(new_name)
end
M.on_attach = function(client, bufnr)
    -- キーマッピングの設定
    local opts = { silent = true, noremap = true }
    local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap
    -- LSP の初期化確認
    if client.server_capabilities then
        lsp_notify:onlysave("LSP initialized for buffer: " .. bufnr)
        lsp_notify:onlysave("Rename capability: " .. tostring(client.server_capabilities.renameProvider))
    else
      lsp_notify:onlysave("LSP not initialized for buffer: " .. bufnr, vim.log.levels.ERROR)
    end
    client.server_capabilities.prepareRenameProvider = nil
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gn", "<cmd>lua custom_rename()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>ge", "<cmd>lua require('usermod.lsp_diagnostics).diagnostics()<CR>" , opts)
    nvim_buf_set_keymap(bufnr, "n", "<Leader>gE", "<cmd>lua require('usermod.lsp_diagnostics').global_diagnostics()<CR>", opts)
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
            e = { "<cmd>lua require('usermod.lsp_diagnostics').diagnostics()<CR>", "Show Line Diagnostics" },
            E = { "<cmd>lua require('usermod.lsp_diagnostics').global_diagnostics()<CR>", "Show Global Diagnostics" },
            q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Set Loclist" },
            f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format Document" },
        },
    }, { prefix = "<space>" })
end

return M
