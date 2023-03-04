local nvim = vim.api
nvim.nvim_set_keymap("n","<Leader>gd",":LspDefinition",{silent=true})
nvim.nvim_set_keymap("n","<Leader>gr",":LspReferences",{silent=true})
