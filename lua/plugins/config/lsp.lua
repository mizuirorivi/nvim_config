local nvim = vim.api

-- local lspconfig = require('lspconfig')

-- ccls setup

-- Enable ccls
-- nvim_lsp.ccls.setup{
--     init_options = {
--         compilationDatabaseDirectory = "build";
--         index = {
--             threads = 0;
--         };
--         clang = {
--             excludeArgs = { "-frounding-math"} ;
--         };
--     }
-- }

-- Enable LSP log for debugging
-- vim.lsp.set_log_level("debug")
nvim.nvim_set_keymap("n","<Leader>gd",":LspDefinition",{silent=true})
nvim.nvim_set_keymap("n","<Leader>gr",":LspReferences",{silent=true})
